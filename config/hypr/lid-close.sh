#!/usr/bin/env bash
set -euo pipefail

printf '%s\n' "Lid-close handler started."

# Start Hyprlock if it is not already running.
if ! pgrep -x hyprlock >/dev/null 2>&1; then
  printf '%s\n' "Hyprlock is not running; starting it."
  hyprlock &
  hyprlock_pid=$!
  printf 'Started Hyprlock with PID %s.\n' "$hyprlock_pid"
else
  printf '%s\n' "Hyprlock is already running."
fi

# Wait until Hyprland explicitly reports an active session lock.
last_status="no response"
for _ in {1..50}; do
  if status="$(hyprctl locked 2>&1)"; then
    status="${status//$'\r'/}"
    if [[ "$status" == "true" ]]; then
      printf '%s\n' "Hyprland confirms that the session is locked; requesting suspend."
      if systemctl suspend; then
        printf '%s\n' "Suspend request completed."
        exit 0
      fi

      printf '%s\n' "ERROR: Suspend request failed; keeping the session locked."
      notify-send -u critical "Hyprlock" \
        "Suspend failed. The session remains locked."
      exit 1
    fi
    last_status="$status"
  else
    last_status="hyprctl locked failed: $status"
  fi

  sleep 0.1
done

printf 'ERROR: Session lock was not confirmed within 5 seconds (last response: %s). Suspend cancelled.\n' "$last_status"
notify-send -u critical "Hyprlock" \
  "Lock screen did not become active. Suspend cancelled."
exit 1
