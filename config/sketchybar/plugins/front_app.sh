#!/bin/sh

if [ "$SENDER" = "front_app_switched" ]; then
  LABEL=$(echo "$INFO" | tr '[:upper:]' '[:lower:]')
  sketchybar --set "$NAME" label="$LABEL"
elif [ "$SENDER" = "aerospace_workspace_change" ]; then
  WINDOW_COUNT=$(aerospace list-windows --workspace "$FOCUSED_WORKSPACE" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$WINDOW_COUNT" = "0" ]; then
    sketchybar --set "$NAME" label=""
  else
    FRONT_APP=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null | tr '[:upper:]' '[:lower:]')
    sketchybar --set "$NAME" label="$FRONT_APP"
  fi
fi
