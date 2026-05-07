#!/usr/bin/env bash

set -euo pipefail

MODE="${1:-area}"
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

STAMP="$(date +'%Y-%m-%d_%H-%M-%S')"
FILE="$DIR/screenshot-$STAMP.png"

notify_done() {
  notify-send "screenshot" "$1" -t 1800 2>/dev/null || true
}

case "$MODE" in
  full)
    grim "$FILE"
    notify_done "saved full screenshot"
    ;;

  area)
    grim -g "$(slurp)" "$FILE"
    notify_done "saved area screenshot"
    ;;

  copy)
    grim -g "$(slurp)" - | wl-copy
    notify_done "copied area screenshot"
    ;;

  edit)
    grim -g "$(slurp)" "$FILE"
    swappy -f "$FILE"
    ;;

  *)
    notify-send "screenshot error" "unknown mode: $MODE" -t 2500 2>/dev/null || true
    exit 1
    ;;
esac
