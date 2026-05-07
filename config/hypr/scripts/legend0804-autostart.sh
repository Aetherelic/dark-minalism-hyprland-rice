#!/usr/bin/env bash

# Nobara/Fedora Hyprland rice autostart

# Stop duplicates
pkill waybar 2>/dev/null || true

# Start wallpaper daemon + set wallpaper
~/.config/hypr/scripts/wallpaper.sh &

# Notification centre
pgrep -x swaync >/dev/null 2>&1 || swaync >/tmp/swaync.log 2>&1 &

# Clipboard history if installed
command -v wl-paste >/dev/null 2>&1 && command -v cliphist >/dev/null 2>&1 && \
  wl-paste --type text --watch cliphist store >/tmp/cliphist-text.log 2>&1 &

# Network/bluetooth tray helpers
command -v nm-applet >/dev/null 2>&1 && nm-applet --indicator >/tmp/nm-applet.log 2>&1 &
command -v blueman-applet >/dev/null 2>&1 && blueman-applet >/tmp/blueman-applet.log 2>&1 &

# Waybar last, after CSS/cache exists
sleep 1
waybar -c "$HOME/.config/waybar/config.jsonc" -s "$HOME/.config/waybar/style.css" >/tmp/waybar.log 2>&1 &
