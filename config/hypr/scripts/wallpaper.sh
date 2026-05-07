#!/usr/bin/env bash

MAIN_MON="DP-2"
SIDE_MON="DP-1"

WALL="$HOME/Pictures/Wallpapers/sidedisplay.jpg"

pgrep -x swww-daemon >/dev/null || {
  swww-daemon --format xrgb >/tmp/swww-daemon.log 2>&1 &
  sleep 1
}

swww img -o "$MAIN_MON" "$WALL" \
  --transition-type grow \
  --transition-duration 1 \
  --transition-fps 60

swww img -o "$SIDE_MON" "$WALL" \
  --transition-type grow \
  --transition-duration 1 \
  --transition-fps 60
