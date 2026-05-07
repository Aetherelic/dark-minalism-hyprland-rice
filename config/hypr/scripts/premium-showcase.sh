#!/usr/bin/env bash

MAIN_MON="DP-2"
DASH_MON="DP-1"

CLEAN_WS="9"
DASH_WS="6"

# Close obvious overlays
pkill rofi 2>/dev/null || true
eww -c "$HOME/.config/eww-legend-power" close legend_power 2>/dev/null || true

# Keep core visual pieces alive
pgrep -x waybar >/dev/null 2>&1 || \
  waybar -c "$HOME/.config/waybar/config.jsonc" -s "$HOME/.config/waybar/style.css" >/tmp/waybar.log 2>&1 &

pgrep -x swww-daemon >/dev/null 2>&1 || \
  swww-daemon --format xrgb >/tmp/swww-daemon.log 2>&1 &

# Refresh wallpaper if your wallpaper script exists
[ -x "$HOME/.config/hypr/scripts/wallpaper.sh" ] && \
  "$HOME/.config/hypr/scripts/wallpaper.sh" >/tmp/showcase-wallpaper.log 2>&1 &

# Put clean workspace on main monitor
hyprctl dispatch moveworkspacetomonitor "$CLEAN_WS" "$MAIN_MON" >/dev/null 2>&1 || true

# Put dashboard workspace on side monitor
hyprctl dispatch moveworkspacetomonitor "$DASH_WS" "$DASH_MON" >/dev/null 2>&1 || true

# Relaunch dashboard
"$HOME/.config/hypr/scripts/legenddash-launch.sh" >/tmp/legenddash-launch.log 2>&1 &

sleep 1.5

# Re-force layout after widgets spawn
hyprctl dispatch moveworkspacetomonitor "$DASH_WS" "$DASH_MON" >/dev/null 2>&1 || true
hyprctl dispatch moveworkspacetomonitor "$CLEAN_WS" "$MAIN_MON" >/dev/null 2>&1 || true

# End focused on the clean main workspace
hyprctl dispatch focusmonitor "$MAIN_MON" >/dev/null 2>&1 || true
hyprctl dispatch workspace "$CLEAN_WS" >/dev/null 2>&1 || true

notify-send "showcase mode" "premium screenshot scene ready" -t 1800 2>/dev/null || true
