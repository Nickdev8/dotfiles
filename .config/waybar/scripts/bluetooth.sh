#!/bin/bash

STATUS=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

if [[ "$1" == "toggle" ]]; then
  if [[ "$STATUS" == "yes" ]]; then
    bluetoothctl power off
  else
    bluetoothctl power on
  fi
fi

# Output for waybar
if [[ "$STATUS" == "yes" ]]; then
  echo "On"
else
  echo "Off"
fi
