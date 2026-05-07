#!/usr/bin/env bash

POWERDIR="$HOME/.config/eww-legend-power"

eww -c "$POWERDIR" daemon >/tmp/eww-legend-power.log 2>&1 || true

if eww -c "$POWERDIR" active-windows 2>/dev/null | grep -q "legend_power"; then
  eww -c "$POWERDIR" close legend_power
else
  eww -c "$POWERDIR" open legend_power
fi
