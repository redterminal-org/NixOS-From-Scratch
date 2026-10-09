{ pkgs, lib, ... }:

let
  vpnAskpass = pkgs.writeShellScript "vpn-askpass" ''
    prompt="''${1:-Administrator password}"
    printf '\n' | ${pkgs.wofi}/bin/wofi --dmenu --password --prompt "$prompt" --cache-file /dev/null
  '';

  vpnSwitchRoot = pkgs.writeShellScriptBin "vpn-switch-root" ''
    set -euo pipefail
    PATH=${lib.makeBinPath [ pkgs.coreutils pkgs.gawk pkgs.glibc.bin pkgs.gnused pkgs.iproute2 pkgs.networkmanager pkgs.nftables ]}
    export PATH
    config=/etc/wireguard/wg0.conf
    table=wg_killswitch

    [ "$(id -u)" -eq 0 ] || { echo "Must run as root." >&2; exit 1; }

    ensure_set() {
      nft list set inet "$table" "$1" >/dev/null 2>&1 ||
        nft add set inet "$table" "$1" "{ type $2; flags interval; }"
    }

    refresh_routes() {
      nft list table inet "$table" >/dev/null 2>&1 || return 0
      nft flush set inet "$table" lan4
      nft flush set inet "$table" lan6
      while IFS= read -r network; do
        [ -n "$network" ] && nft add element inet "$table" lan4 "{ $network }" || true
      done < <(ip -4 route show table main type unicast | awk '
        $1 != "default" && $0 !~ / dev wg0([[:space:]]|$)/ &&
        ($0 !~ / via / || $1 ~ /^10\./ || $1 ~ /^192\.168\./ ||
         $1 ~ /^172\.(1[6-9]|2[0-9]|3[01])\./) { print $1 }')
      while IFS= read -r network; do
        [ -n "$network" ] && nft add element inet "$table" lan6 "{ $network }" || true
      done < <(ip -6 route show table main type unicast | awk '
        $1 != "default" && $0 !~ / dev wg0([[:space:]]|$)/ &&
        ($0 !~ / via / || tolower($1) ~ /^fc/ || tolower($1) ~ /^fd/) { print $1 }')
    }

    case "''${1:-}" in
      on)
        [ -f "$config" ] || { echo "Missing $config; import private data first." >&2; exit 1; }
        endpoint="$(awk -F= '/^[[:space:]]*Endpoint[[:space:]]*=/ {gsub(/[[:space:]]/, "", $1); gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2); print $2; exit}' "$config")"
        case "$endpoint" in
          \[*\]:*) host="''${endpoint#\[}"; host="''${host%%\]*}"; port="''${endpoint##*:}" ;;
          *:*) host="''${endpoint%:*}"; port="''${endpoint##*:}" ;;
          *) echo "Invalid WireGuard Endpoint." >&2; exit 1 ;;
        esac
        case "$port" in ""|*[!0-9]*) echo "Invalid WireGuard endpoint port." >&2; exit 1 ;; esac
        [ "$port" -ge 1 ] && [ "$port" -le 65535 ] || { echo "Endpoint port out of range." >&2; exit 1; }

        addresses="$(getent ahosts "$host" | awk '{print $1}' | sort -u || true)"
        if [ -z "$addresses" ] &&
           ! nft list set inet "$table" endpoint4 >/dev/null 2>&1 &&
           ! nft list set inet "$table" endpoint6 >/dev/null 2>&1; then
          echo "Cannot resolve WireGuard endpoint: $host" >&2; exit 1
        fi

        nft list table inet "$table" >/dev/null 2>&1 || nft add table inet "$table"
        ensure_set lan4 ipv4_addr
        ensure_set lan6 ipv6_addr
        ensure_set endpoint4 ipv4_addr
        ensure_set endpoint6 ipv6_addr
        nft list chain inet "$table" output >/dev/null 2>&1 ||
          nft add chain inet "$table" output '{ type filter hook output priority -50; policy drop; }'

        nft flush chain inet "$table" output
        nft flush set inet "$table" lan4
        nft flush set inet "$table" lan6
        if [ -n "$addresses" ]; then
          nft flush set inet "$table" endpoint4
          nft flush set inet "$table" endpoint6
        fi

        nft add rule inet "$table" output oifname "lo" accept
        nft add rule inet "$table" output oifname "wg0" accept
        nft add rule inet "$table" output ip daddr @lan4 accept
        nft add rule inet "$table" output ip6 daddr @lan6 accept
        nft add rule inet "$table" output ip6 daddr fe80::/10 accept
        nft add rule inet "$table" output ip6 daddr ff02::/16 accept
        nft add rule inet "$table" output udp sport 68 udp dport 67 accept
        nft add rule inet "$table" output udp sport 546 udp dport 547 accept

        if [ -n "$addresses" ]; then
          for address in $addresses; do
            case "$address" in
              *:*) nft add element inet "$table" endpoint6 "{ $address }" ;;
              *) nft add element inet "$table" endpoint4 "{ $address }" ;;
            esac
          done
        fi
        nft add rule inet "$table" output ip daddr @endpoint4 udp dport "$port" accept
        nft add rule inet "$table" output ip6 daddr @endpoint6 udp dport "$port" accept
        refresh_routes
        # Drop policy is active before the tunnel is started; failures stay fail-closed.
        nmcli connection up wg0
        ;;
      off)
        nmcli connection down wg0 2>/dev/null || true
        nft delete table inet "$table" 2>/dev/null || true
        ;;
      refresh) refresh_routes ;;
      status)
        if nft list table inet "$table" >/dev/null 2>&1; then echo "VPN switch: ON (kill switch active)"; else echo "VPN switch: OFF"; fi
        nmcli connection show --active
        ;;
      *) echo "Usage: vpn-switch on|off|status" >&2; exit 2 ;;
    esac
  '';

  vpnPrivateImport = pkgs.writeShellScriptBin "vpn-private-import" ''
    set -euo pipefail
    PATH=${lib.makeBinPath [ pkgs.coreutils pkgs.networkmanager ]}
    export PATH
    source_file="''${1:-}"
    [ "$(id -u)" -eq 0 ] || { echo "Must run as root." >&2; exit 1; }
    [ -f "$source_file" ] || { echo "WireGuard configuration file is missing." >&2; exit 1; }
    install -D -o root -g root -m 600 "$source_file" /etc/wireguard/wg0.conf
    nmcli connection delete wg0 >/dev/null 2>&1 || true
    nmcli connection import type wireguard file /etc/wireguard/wg0.conf
    nmcli connection modify wg0 connection.id wg0 connection.autoconnect no
  '';

  vpnSwitch = pkgs.writeShellScriptBin "vpn-switch" ''
    export SUDO_ASKPASS="${vpnAskpass}"
    exec ${pkgs.sudo}/bin/sudo -A ${vpnSwitchRoot}/bin/vpn-switch-root "$@"
  '';

  vpnDispatcher = pkgs.writeShellScript "vpn-route-refresh" ''
    case "''${2:-}" in
      up|down|dhcp4-change|dhcp6-change|connectivity-change)
        exec ${vpnSwitchRoot}/bin/vpn-switch-root refresh ;;
    esac
  '';
in
{
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;
  networking.firewall.checkReversePath = "loose";
  environment.systemPackages = [ vpnPrivateImport vpnSwitch vpnSwitchRoot ];
  networking.networkmanager.dispatcherScripts = [
    { source = vpnDispatcher; type = "basic"; }
  ];
}
