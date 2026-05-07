#!/usr/bin/env bash

printf '\033[?25l'
trap 'printf "\033[?25h"; exit' INT TERM EXIT

export TERM=xterm-256color

while true; do
  # Same seed for one full growth cycle, then new seed for next tree
  SEED="$RANDOM"

  for LIFE in 3 5 7 9 11 13 15 17 19 21 23; do
    clear

    cbonsai \
      -p \
      -s "$SEED" \
      -L "$LIFE" \
      -M 4 \
      -b 1 \
      -c ".,*,+" \
      2>/tmp/legenddash-bonsai.log

    sleep 0.18
  done

  # Hold the fully-grown tree for a moment before growing a new one
  sleep 2
done
