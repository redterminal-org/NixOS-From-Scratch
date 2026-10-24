#!/usr/bin/env bash
set -u

readonly connectivity_url="http://ping.archlinux.org/nm-check.txt"
readonly -a curl_args=(--connect-timeout 2 --max-time 3 --fail --silent)

emit_status() {
    printf '{"text":"%s","class":"%s"}\n' "$1" "$2"
}

route="$(ip -4 route show default 2>/dev/null | head -n 1)"
gateway="$(awk '{for (i = 1; i <= NF; i++) if ($i == "via") {print $(i + 1); exit}}' <<< "$route")"
interface="$(awk '{for (i = 1; i <= NF; i++) if ($i == "dev") {print $(i + 1); exit}}' <<< "$route")"

if [[ -z "$gateway" || -z "$interface" ]]; then
    emit_status "Disconnected ⚠" "disconnected"
    exit 0
fi

if ! ping -c 1 -W 1 "$gateway" >/dev/null 2>&1; then
    if ! ip neigh show "$gateway" dev "$interface" 2>/dev/null |
        awk '$NF ~ /^(REACHABLE|STALE|DELAY|PROBE)$/ {found = 1} END {exit !found}'; then
        emit_status "Disconnected ⚠" "disconnected"
        exit 0
    fi
fi

for attempt in 1 2; do
    if response="$(
        curl "${curl_args[@]}" "$connectivity_url" 2>/dev/null
    )" && [[ "$response" == "NetworkManager is online" ]]; then
        emit_status "Online" "online"
        exit 0
    fi
done

emit_status "Nur Lokal" "local"
