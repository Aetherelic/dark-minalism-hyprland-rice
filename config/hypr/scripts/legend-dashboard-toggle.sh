#!/usr/bin/env bash
EWWDIR="$HOME/.config/eww"

if eww -c "$EWWDIR" active-windows 2>/dev/null | grep -q "dashboard_clock"; then
  eww -c "$EWWDIR" close dashboard_clock >/dev/null 2>&1 || true
  eww -c "$EWWDIR" close dashboard_info >/dev/null 2>&1 || true
else
  "$HOME/.config/hypr/scripts/legend-dashboard.sh"
fi
