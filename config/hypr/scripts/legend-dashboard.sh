#!/usr/bin/env bash
EWWDIR="$HOME/.config/eww"

eww -c "$EWWDIR" kill >/dev/null 2>&1 || true
sleep 0.4

eww -c "$EWWDIR" daemon >/tmp/eww-dashboard.log 2>&1 &
sleep 1

eww -c "$EWWDIR" open dashboard_clock
eww -c "$EWWDIR" open dashboard_info
