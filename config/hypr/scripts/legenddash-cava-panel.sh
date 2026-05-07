#!/usr/bin/env bash
clear

if ! command -v cava >/dev/null 2>&1; then
  echo "cava is missing"
  echo "Run: sudo dnf install cava"
  sleep infinity
fi

echo "Starting cava..."
sleep 0.5

cava -p "$HOME/.config/dashboard/cava-top.conf" 2>/tmp/legenddash-cava.log
echo
echo "cava exited. Log:"
cat /tmp/legenddash-cava.log 2>/dev/null
sleep infinity
