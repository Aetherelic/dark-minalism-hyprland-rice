#!/usr/bin/env bash

if command -v jq >/dev/null 2>&1; then
  hyprctl clients -j | jq -r '
    .[] | select(
      .class=="legenddash-clock" or
      .class=="legenddash-fetch" or
      .class=="legenddash-cava"
    ) | .address
  ' | while read -r addr; do
    [ -n "$addr" ] && hyprctl dispatch closewindow "address:$addr" >/dev/null 2>&1 || true
  done
fi

pkill -f "cava -p $HOME/.config/cava/legenddash.conf" 2>/dev/null || true
