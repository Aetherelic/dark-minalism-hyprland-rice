#!/usr/bin/env bash

DASH_MON="DP-1"
DASH_WS="6"

close_dashboard() {
  pkill -f "kitty.*legenddash-clock" 2>/dev/null || true
  pkill -f "kitty.*legenddash-fetch" 2>/dev/null || true
  pkill -f "kitty.*legenddash-cava" 2>/dev/null || true
  pkill -f "kitty.*legenddash-bonsai" 2>/dev/null || true
  pkill -f "kitty.*legenddash-pattern" 2>/dev/null || true
}

get_monitor_xy() {
  hyprctl monitors -j | jq -r ".[] | select(.name==\"$DASH_MON\") | \"\(.x) \(.y)\""
}

place_window() {
  local class="$1"
  local w="$2"
  local h="$3"
  local x="$4"
  local y="$5"
  local addr=""
  local floating=""

  for _ in {1..60}; do
    addr="$(hyprctl clients -j | jq -r --arg class "$class" '.[] | select(.class==$class) | .address' | head -n1)"

    if [ -n "$addr" ] && [ "$addr" != "null" ]; then
      floating="$(hyprctl clients -j | jq -r --arg addr "$addr" '.[] | select(.address==$addr) | .floating' | head -n1)"

      if [ "$floating" != "true" ] && [ "$floating" != "1" ]; then
        hyprctl dispatch togglefloating "address:$addr" >/dev/null 2>&1 || true
        sleep 0.15
      fi

      hyprctl dispatch movetoworkspacesilent "$DASH_WS,address:$addr" >/dev/null 2>&1 || true
      hyprctl dispatch resizewindowpixel "exact $w $h,address:$addr" >/dev/null 2>&1 || true
      hyprctl dispatch movewindowpixel "exact $x $y,address:$addr" >/dev/null 2>&1 || true
      return
    fi

    sleep 0.05
  done
}

close_dashboard
sleep 0.2

read MON_X MON_Y < <(get_monitor_xy)
[ -z "${MON_X:-}" ] && MON_X=2560
[ -z "${MON_Y:-}" ] && MON_Y=180

CLOCK_X=$((MON_X + 20))
CLOCK_Y=$((MON_Y + 300))

FETCH_X=$((MON_X + 900))
FETCH_Y=$((MON_Y + 25))

CAVA_X=$((MON_X + 900))
CAVA_Y=$((MON_Y + 840))

# Small real cbonsai decoration below the clock
BONSAI_X=$((MON_X + 430))
BONSAI_Y=$((MON_Y + 725))

hyprctl dispatch moveworkspacetomonitor "$DASH_WS" "$DASH_MON" >/dev/null 2>&1 || true

kitty --class legenddash-clock --title legenddash-clock \
  --config "$HOME/.config/kitty/legenddash-clock.conf" \
  "$HOME/.config/hypr/scripts/legenddash-clock-panel.py" >/tmp/legenddash-clock.log 2>&1 &

kitty --class legenddash-fetch --title legenddash-fetch \
  --config "$HOME/.config/kitty/legenddash-fetch.conf" \
  "$HOME/.config/hypr/scripts/legenddash-fetch-panel.sh" >/tmp/legenddash-fetch.log 2>&1 &

kitty --class legenddash-cava --title legenddash-cava \
  --config "$HOME/.config/kitty/legenddash-cava.conf" \
  sh -lc 'cava -p "$HOME/.config/dashboard/cava-top.conf"; sleep infinity' >/tmp/legenddash-cava.log 2>&1 &

kitty --class legenddash-bonsai --title legenddash-bonsai \
  --config "$HOME/.config/kitty/legenddash-bonsai.conf" \
  "$HOME/.config/hypr/scripts/legenddash-bonsai.sh" >/tmp/legenddash-bonsai.log 2>&1 &

sleep 1.2

place_window "legenddash-clock" 900 390 "$CLOCK_X" "$CLOCK_Y"
place_window "legenddash-fetch" 760 360 "$FETCH_X" "$FETCH_Y"
place_window "legenddash-cava" 930 140 "$CAVA_X" "$CAVA_Y"
place_window "legenddash-bonsai" 360 260 "$BONSAI_X" "$BONSAI_Y"

hyprctl dispatch moveworkspacetomonitor "$DASH_WS" "$DASH_MON" >/dev/null 2>&1 || true
