{ config, pkgs, ... }:

let
  sshAskpass = pkgs.writeShellScript "ssh-askpass" ''
    prompt="''${1:-SSH password}"

    printf '\n' | ${pkgs.wofi}/bin/wofi \
      --dmenu \
      --password \
      --prompt "$prompt" \
      --cache-file /dev/null
  '';

  promptRemote = pkgs.writeShellScript "prompt-private-remote" ''
    printf '\n' | ${pkgs.wofi}/bin/wofi \
      --dmenu \
      --prompt "Secrets Import per SSH: '<user>@<server>' or '<ENTER>' for no import" \
      --cache-file /dev/null
  '';

  promptPath = pkgs.writeShellScript "prompt-private-path" ''
    printf '\n' | ${pkgs.wofi}/bin/wofi \
      --dmenu \
      --prompt "Secrets path on server" \
      --cache-file /dev/null
  '';

  notify = pkgs.writeShellScript "notify-private-data" ''
    ${pkgs.libnotify}/bin/notify-send \
      -a "NixOS" \
      "$1" \
      "$2"
  '';

  importPrivateData = pkgs.writeShellScript "import-private-data" ''
    set -u

    marker="$HOME/.local/state/.nixos-private-data-import-marker"
    tmpdir="$HOME/.cache/nixos-private-data"

    if [ -e "$marker" ]; then
      exit 0
    fi

    mkdir -p "$(dirname "$marker")"

    remote="$(${promptRemote})"

    if [ -z "$remote" ]; then
      ${notify} \
        "Private data" \
        "No secrets imported. The installation marker was set. You'll not be asked again."

      touch "$marker"
      chmod 600 "$marker"
      exit 0
    fi

    case "$remote" in
      *@*)
        remoteUser="''${remote%@*}"
        remoteHost="''${remote#*@}"
        ;;
      *)
        ${notify} \
          "Private data error" \
          "Invalid SSH destination. Expected user@server. Login again to try again."

        exit 1
        ;;
    esac

    if [ -z "$remoteUser" ] || [ -z "$remoteHost" ]; then
      ${notify} \
        "Private data error" \
        "Invalid SSH destination. Expected user@server."

      exit 1
    fi

    remotePath="$(${promptPath})"

    if [ -z "$remotePath" ]; then
      ${notify} \
        "Private data error" \
        "No secrets path was provided."

      exit 1
    fi

    rm -rf "$tmpdir"
    mkdir -p "$tmpdir"

    cleanup() {
      rm -rf "$tmpdir"
    }

    trap cleanup EXIT

    if ! ${pkgs.netcat-openbsd}/bin/nc \
      -z \
      -w 3 \
      "$remoteHost" \
      22; then

      ${notify} \
        "Private data error" \
        "Server $remoteHost is not reachable. You will be asked again at the next login."

      exit 0
    fi

    export SSH_ASKPASS="${sshAskpass}"
    export SSH_ASKPASS_REQUIRE=force

    remoteSource="''${remoteUser}@''${remoteHost}:''${remotePath}"

    if ! ${pkgs.openssh}/bin/scp \
      -o BatchMode=no \
      -o StrictHostKeyChecking=accept-new \
      -r \
      "$remoteSource/." \
      "$tmpdir/"; then

      ${notify} \
        "Private data error" \
        "Could not download the private data. No marker was set."

      exit 1
    fi

    if [ ! -f "$tmpdir/gnupg/secret.asc" ]; then
      ${notify} \
        "Private data error" \
        "The downloaded data does not contain gnupg/secret.asc."

      exit 1
    fi

    if [ ! -f "$tmpdir/gnupg/public.asc" ]; then
      ${notify} \
        "Private data error" \
        "The downloaded data does not contain gnupg/public.asc."

      exit 1
    fi

    if [ ! -d "$tmpdir/ssh" ]; then
      ${notify} \
        "Private data error" \
        "The downloaded data does not contain the SSH directory."

      exit 1
    fi

    if [ ! -d "$tmpdir/password-store" ]; then
      ${notify} \
        "Private data error" \
        "The downloaded data does not contain password-store."

      exit 1
    fi

    if [ ! -d "$tmpdir/rogallo" ]; then
      ${notify} \
        "Private data error" \
        "The downloaded data does not contain rogallo."

      exit 1
    fi

    if ! ${pkgs.gnupg}/bin/gpg \
      --batch \
      --import "$tmpdir/gnupg/secret.asc"; then

      ${notify} \
        "Private data error" \
        "The GPG secret key could not be imported."

      exit 1
    fi

    if ! ${pkgs.gnupg}/bin/gpg \
      --batch \
      --import "$tmpdir/gnupg/public.asc"; then

      ${notify} \
        "Private data error" \
        "The GPG public keys could not be imported."

      exit 1
    fi

    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"

    ${pkgs.coreutils}/bin/cp -a \
      "$tmpdir/ssh/." \
      "$HOME/.ssh/"

    find "$HOME/.ssh" \
      -type f \
      -name 'id_*' \
      ! -name '*.pub' \
      -exec chmod 600 {} \;

    find "$HOME/.ssh" \
      -type f \
      -name '*.pub' \
      -exec chmod 644 {} \;

    mkdir -p "$HOME/.password-store"
    chmod 700 "$HOME/.password-store"

    ${pkgs.coreutils}/bin/cp -a \
      "$tmpdir/password-store/." \
      "$HOME/.password-store/"

    find "$HOME/.password-store" \
      -type d \
      -exec chmod 700 {} \;

    find "$HOME/.password-store" \
      -type f \
      -exec chmod 600 {} \;

    mkdir -p "$HOME/.local/share/rogallo"
    chmod 700 "$HOME/.local/share/rogallo"

    ${pkgs.coreutils}/bin/cp -a \
      "$tmpdir/rogallo/." \
      "$HOME/.local/share/rogallo/"

    find "$HOME/.local/share/rogallo" \
      -type d \
      -exec chmod 700 {} \;

    find "$HOME/.local/share/rogallo" \
      -type f \
      -exec chmod 600 {} \;

    touch "$marker"
    chmod 600 "$marker"

    ${notify} \
      "Private data" \
      "Secrets imported successfully."
  '';

in
{
  systemd.user.services.import-private-data = {
    Unit = {
      Description = "Import private NixOS data";
    };

    Service = {
      Type = "oneshot";

      Environment = [
        "SSH_ASKPASS_REQUIRE=force"
        "SSH_ASKPASS=${sshAskpass}"
      ];

      ExecStart = importPrivateData;
    };
  };
}
