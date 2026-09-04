#!/usr/bin/env bash

# sketchybar runs plugins with a trimmed PATH that omits /usr/local/bin, so
# reference the internal `a` CLI by its absolute path.
A_BIN="/usr/local/bin/a"

# The VPN item is only relevant on machines where the internal `a` CLI exists.
if [ ! -x "$A_BIN" ]; then
    sketchybar --set "$NAME" drawing=off
    exit 0
fi

STATUS="$("$A_BIN" vpn status 2>/dev/null)"

# "Connected to Bastion VPN" -> label "bastion"; anything else means down.
if [[ "$STATUS" == Connected\ to\ * ]]; then
    NETWORK="${STATUS#Connected to }"
    NETWORK="${NETWORK% VPN}"
    LABEL="$(echo "$NETWORK" | tr '[:upper:]' '[:lower:]')"
    sketchybar --set "$NAME" drawing=on icon="󰦝" label="$LABEL"
else
    sketchybar --set "$NAME" drawing=off
fi
