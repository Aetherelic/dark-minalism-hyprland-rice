#!/usr/bin/env bash

printf '\033[?25l'
trap "printf '\033[?25h'; exit" INT TERM EXIT

while true; do
  clear
  if command -v cbonsai >/dev/null 2>&1; then
    cbonsai -l -t 0.04 2>/tmp/legenddash-bonsai.log || cbonsai 2>/tmp/legenddash-bonsai.log
    sleep 3
  else
    echo "cbonsai missing"
    echo "Run: sudo dnf install cbonsai"
    sleep 10
  fi
done
