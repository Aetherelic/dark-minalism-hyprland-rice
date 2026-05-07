#!/usr/bin/env bash

if command -v jq >/dev/null 2>&1 && hyprctl clients -j | jq -e '
  .[] | select(
    .class=="legenddash-clock" or
    .class=="legenddash-fetch" or
    .class=="legenddash-cava"
  )
' >/dev/null; then
  "$HOME/.config/hypr/scripts/legenddash-close.sh"
else
  "$HOME/.config/hypr/scripts/legenddash-launch.sh"
fi
