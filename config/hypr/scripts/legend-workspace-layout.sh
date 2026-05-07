#!/usr/bin/env bash

MAIN="DP-2"
OTHER="DP-1"

for ws in 1 2 3 4 5; do
  hyprctl dispatch moveworkspacetomonitor "$ws" "$MAIN" >/dev/null 2>&1 || true
done

for ws in 6 7 8 9 10; do
  hyprctl dispatch moveworkspacetomonitor "$ws" "$OTHER" >/dev/null 2>&1 || true
done
