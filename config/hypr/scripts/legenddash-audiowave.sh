#!/usr/bin/env bash
set -euo pipefail

pkill -f "kitty.*legend-cava" 2>/dev/null || true
sleep 0.15

kitty \
  --class legend-cava \
  --name legend-cava \
  --title legend-cava \
  --config "$HOME/.config/kitty/legenddash-cava.conf" \
  bash -lc 'cava -p "$HOME/.config/cava/legenddash.conf"'
