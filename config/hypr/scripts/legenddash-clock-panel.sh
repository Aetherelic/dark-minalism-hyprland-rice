#!/usr/bin/env bash

printf '\033[?25l'
trap "printf '\033[?25h'; exit" INT TERM EXIT

center_line() {
  local text="$1"
  local cols
  cols=$(tput cols 2>/dev/null || echo 80)
  local plain
  plain="$(printf '%s' "$text" | sed 's/\x1b\[[0-9;]*m//g')"
  local len=${#plain}
  local pad=$(( (cols - len) / 2 ))
  [ "$pad" -lt 0 ] && pad=0
  printf "%*s%s\n" "$pad" "" "$text"
}

frames=("◜" "◝" "◞" "◟")
i=0

while true; do
  frame="${frames[$i]}"
  i=$(( (i + 1) % 4 ))

  HOUR="$(date +'%H')"
  MIN="$(date +'%M')"
  SEC="$(date +'%S')"
  DATE1="$(date +'%A')"
  DATE2="$(date +'%d %B %Y')"

  # blinking colon
  if [ $((10#$SEC % 2)) -eq 0 ]; then
    TIME="${HOUR}:${MIN}"
  else
    TIME="${HOUR} ${MIN}"
  fi

  clear
  printf "\n\n\n"

  center_line "$(printf '\033[38;2;166;227;161m%s\033[0m' "━━━━━━━━━━━━━━━━━━━━━━━━━━━━")"
  printf "\n"

  center_line "$(printf '\033[38;2;205;214;244m%s\033[0m' "$DATE1")"
  center_line "$(printf '\033[38;2;148;226;213m%s  %s  %s\033[0m' "$frame" "$DATE2" "$frame")"

  printf "\n"

  center_line "$(printf '\033[1;38;2;203;166;247m%s\033[0m' "$TIME")"

  printf "\n"

  center_line "$(printf '\033[38;2;137;180;250m%s\033[0m' "Nobara Hyprland")"

  printf "\n"
  center_line "$(printf '\033[38;2;166;227;161m%s\033[0m' "━━━━━━━━━━━━━━━━━━━━━━━━━━━━")"

  sleep 1
done
