#!/usr/bin/env bash

if ! pgrep -x "Spotify" >/dev/null 2>&1; then
    sketchybar --set "$NAME" drawing=off
    exit 0
fi

PLAYER_STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)

if [[ "$PLAYER_STATE" == "playing" ]]; then
    TRACK=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)
    LABEL=$(echo "$ARTIST - $TRACK" | tr '[:upper:]' '[:lower:]')
    sketchybar --set "$NAME" label="$LABEL" drawing=on
else
    sketchybar --set "$NAME" drawing=off
fi
