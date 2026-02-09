#!/usr/bin/env bash
# Fires desktop notifications at 20%, 10%, 5% when discharging.
# Resets (and optionally thanks you) when you plug in.

set -euo pipefail

# Detect BAT path (BAT0/BAT1...)
BAT_PATH="$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -n1)"
[ -z "${BAT_PATH:-}" ] && exit 0  # no battery? just exit cleanly

CAPACITY="$(cat "$BAT_PATH/capacity")"
STATUS="$(cat "$BAT_PATH/status" 2>/dev/null || echo Unknown)"

TH1=20
TH2=10
TH3=5
STATE_FILE="/tmp/.batt_notify_state"

LAST="OK"
[ -f "$STATE_FILE" ] && LAST="$(cat "$STATE_FILE")"

if [[ "$STATUS" == "Discharging" ]]; then
  if (( CAPACITY <= TH3 )) && [[ "$LAST" != "CRIT3" ]]; then
    notify-send -u critical "Battery ${CAPACITY}% — Plug in now"
    echo "CRIT3" > "$STATE_FILE"
  elif (( CAPACITY <= TH2 )) && [[ "$LAST" != "CRIT2" ]]; then
    notify-send -u critical "Battery low (${CAPACITY}%)"
    echo "CRIT2" > "$STATE_FILE"
  elif (( CAPACITY <= TH1 )) && [[ "$LAST" != "CRIT1" ]]; then
    notify-send -u normal "Battery low (${CAPACITY}%)"
    echo "CRIT1" > "$STATE_FILE"
  fi
else
  # Reset once when you plug in or are not discharging
  if [[ "$LAST" != "OK" ]]; then
    # optional: uncomment next line if you want a “charging” toast
    # notify-send -u low "Charging" "Thanks for plugging in."
    :
  fi
  echo "OK" > "$STATE_FILE"
fi

# Output a minimal JSON so Waybar’s custom module stays invisible
printf '{"text":"","tooltip":"","class":"hidden"}\n'
