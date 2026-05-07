#!/usr/bin/env bash

if [ -x "$HOME/.local/bin/hypr-dashboard" ]; then
  "$HOME/.local/bin/hypr-dashboard"
else
  notify-send "Old dashboard missing" "$HOME/.local/bin/hypr-dashboard was not found or is not executable"
fi
