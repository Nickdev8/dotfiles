#!/usr/bin/env bash
set -e

# Find an XWayland DISPLAY if not present (Hyprland binds often lack it)
if [ -z "${DISPLAY:-}" ]; then
  if [ -e /tmp/.X11-unix/X0 ]; then
    export DISPLAY=:0
  elif [ -e /tmp/.X11-unix/X1 ]; then
    export DISPLAY=:1
  fi
fi

# Allow root to connect to your X server
/usr/bin/xhost +si:localuser:root >/dev/null

# Launch Code as root with your proven flags
exec sudo -n -E /usr/bin/code --ozone-platform=x11 \
  --user-data-dir="/root/.vscode-root" \
  --no-sandbox \
  --high-dpi-support=1 \
  --force-device-scale-factor=1.5
