#!/usr/bin/env bash

DASH_WS=5

# Close only our dashboard windows
if command -v jq >/dev/null 2>&1; then
  for addr in $(hyprctl clients -j | jq -r '.[] | select(.class=="legend-tty-clock" or .class=="legend-neofetch") | .address'); do
    hyprctl dispatch closewindow "address:$addr" >/dev/null 2>&1 || true
  done
else
  pkill -f "legend-tty-clock" 2>/dev/null || true
  pkill -f "legend-neofetch" 2>/dev/null || true
fi

sleep 0.3
hyprctl dispatch workspace "$DASH_WS" >/dev/null 2>&1 || true
sleep 0.3

kitty \
  --detach \
  --hold \
  --config "$HOME/.config/kitty/legend-dashboard-kitty.conf" \
  --class legend-tty-clock \
  --title legend-tty-clock \
  sh -lc '
    if command -v tty-clock >/dev/null 2>&1; then
      tty-clock -c -C 2
    else
      echo "tty-clock is not installed"
      echo "Run: sudo dnf install tty-clock"
      sleep 999999
    fi
  ' &

sleep 0.7

kitty \
  --detach \
  --hold \
  --config "$HOME/.config/kitty/legend-dashboard-kitty.conf" \
  --class legend-neofetch \
  --title legend-neofetch \
  sh -lc '
    clear
    neofetch --config "$HOME/.config/neofetch/legend0804.conf" --kitty "$HOME/koi-hyprland-rice/config/fastfetch/lantern.png"
    exec bash
  ' &
