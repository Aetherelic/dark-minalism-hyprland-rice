#!/usr/bin/env bash

if command -v jq >/dev/null 2>&1 && hyprctl clients -j | jq -e '.[] | select(.class=="legend-tty-clock" or .class=="legend-neofetch")' >/dev/null; then
  for addr in $(hyprctl clients -j | jq -r '.[] | select(.class=="legend-tty-clock" or .class=="legend-neofetch") | .address'); do
    hyprctl dispatch closewindow "address:$addr" >/dev/null 2>&1 || true
  done
else
  "$HOME/.config/hypr/scripts/legend-terminal-dashboard.sh"
fi
