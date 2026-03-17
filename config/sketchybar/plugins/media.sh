#!/usr/bin/env bash

PLAYER_STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)

if [[ "$PLAYER_STATE" == "playing" ]]; then
    TRACK=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
    ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)
    sketchybar --set "$NAME" label="$ARTIST - $TRACK" drawing=on
else
    sketchybar --set "$NAME" drawing=off
fi
