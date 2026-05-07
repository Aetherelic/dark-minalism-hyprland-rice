#!/usr/bin/env bash

trim() {
  local s="$1"
  local max="${2:-50}"
  [ "${#s}" -le "$max" ] && {
    printf '%s' "$s"
    return
  }
  printf '%s…' "${s:0:$((max-1))}"
}

json_escape() {
  jq -Rn --arg s "$1" '$s'
}

PLAYER_STATUS="$(playerctl status 2>/dev/null || true)"

if [ "$PLAYER_STATUS" = "Playing" ] || [ "$PLAYER_STATUS" = "Paused" ]; then
  ARTIST="$(playerctl metadata artist 2>/dev/null || true)"
  TITLE="$(playerctl metadata title 2>/dev/null || true)"
  TEXT="󰎆 $(trim "${ARTIST:+$ARTIST — }$TITLE" 46)"
  CLASS="playing"
  TOOLTIP="Music"
else
  TITLE="$(hyprctl activewindow -j 2>/dev/null | jq -r '.title // empty')"
  CLASS_RAW="$(hyprctl activewindow -j 2>/dev/null | jq -r '.class // empty')"

  if [ -n "$TITLE" ]; then
    TEXT="󰣆 $(trim "$TITLE" 48)"
    CLASS="window"
    TOOLTIP="${CLASS_RAW:-Focused window}"
  else
    TEXT="  premium hyprland"
    CLASS="idle"
    TOOLTIP="Idle"
  fi
fi

printf '{"text":%s,"tooltip":%s,"class":%s}\n' \
  "$(json_escape "$TEXT")" \
  "$(json_escape "$TOOLTIP")" \
  "$(json_escape "$CLASS")"
