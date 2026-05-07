#!/usr/bin/env bash

RESET="\033[0m"
FG="\033[38;2;215;219;210m"
MUTED="\033[38;2;139;152;146m"
DIM="\033[38;2;95;111;107m"
ACCENT="\033[38;2;157;182;173m"
ACCENT2="\033[38;2;195;204;184m"

trim() {
  printf "%s" "$1" | sed 's/  */ /g' | cut -c1-38
}

while true; do
  OS_NAME="$(. /etc/os-release 2>/dev/null && echo "${PRETTY_NAME:-Nobara Linux}")"
  OS_NAME="$(echo "$OS_NAME" | sed 's/ (GNOME Edition)//g')"

  KERNEL="$(uname -r | sed 's/\.x86_64//g')"
  HOST="$(hostname)"
  UPTIME="$(uptime -p | sed 's/up //')"
  SHELL_NAME="$(basename "$SHELL")"

  CPU="$(lscpu 2>/dev/null | awk -F: '/Model name/ {gsub(/^[ \t]+/, "", $2); print $2; exit}')"
  CPU="$(echo "$CPU" | sed 's/AMD //g; s/ 6-Core Processor//g; s/ Processor//g')"

  GPU="$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | head -n1)"
  [ -z "$GPU" ] && GPU="$(lspci 2>/dev/null | grep -Ei 'vga|3d|display' | head -n1 | sed 's/.*: //')"

  MEM="$(free -h | awk '/Mem:/ {print $3 " / " $2}')"
  DISK="$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')"

  OS_NAME="$(trim "$OS_NAME")"
  KERNEL="$(trim "$KERNEL")"
  HOST="$(trim "$HOST")"
  CPU="$(trim "$CPU")"
  GPU="$(trim "$GPU")"
  MEM="$(trim "$MEM")"
  DISK="$(trim "$DISK")"
  UPTIME="$(trim "$UPTIME")"

  clear
  printf '\033[?25l'

  printf "\n"
  printf "  ${ACCENT2}aetherelic${RESET} ${DIM}// premium unixporn${RESET}\n"
  printf "  ${DIM}──────────────────────────────────────${RESET}\n\n"

  printf "  ${ACCENT}software${RESET}\n"
  printf "    ${MUTED}os      ${DIM}→${RESET} ${FG}%s${RESET}\n" "$OS_NAME"
  printf "    ${MUTED}host    ${DIM}→${RESET} ${FG}%s${RESET}\n" "$HOST"
  printf "    ${MUTED}kernel  ${DIM}→${RESET} ${FG}%s${RESET}\n" "$KERNEL"
  printf "    ${MUTED}wm      ${DIM}→${RESET} ${FG}Hyprland${RESET}\n"
  printf "    ${MUTED}shell   ${DIM}→${RESET} ${FG}%s${RESET}\n" "$SHELL_NAME"

  printf "\n"
  printf "  ${ACCENT}hardware${RESET}\n"
  printf "    ${MUTED}cpu     ${DIM}→${RESET} ${FG}%s${RESET}\n" "$CPU"
  printf "    ${MUTED}gpu     ${DIM}→${RESET} ${FG}%s${RESET}\n" "$GPU"
  printf "    ${MUTED}memory  ${DIM}→${RESET} ${FG}%s${RESET}\n" "$MEM"
  printf "    ${MUTED}disk    ${DIM}→${RESET} ${FG}%s${RESET}\n" "$DISK"
  printf "    ${MUTED}uptime  ${DIM}→${RESET} ${FG}%s${RESET}\n" "$UPTIME"

  sleep 30
done
