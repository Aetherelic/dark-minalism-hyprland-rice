#!/usr/bin/env bash
LOC="${1:-London+UK}"
TXT="$(curl -fsS "https://wttr.in/${LOC}?format=%c +%t" 2>/dev/null || echo "☁ +--")"
printf '{"text":"%s","tooltip":"Weather: %s"}\n' "$TXT" "$TXT"
