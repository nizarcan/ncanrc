#!/bin/sh

# Runs on volume_change (INFO = volume %) and audio_output_change (cycled device).
# Query the system directly so the label is correct regardless of sender.

VOLUME=$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)
DEVICE=$(SwitchAudioSource -c -t output 2>/dev/null | tr '[:upper:]' '[:lower:]')

case "$VOLUME" in
  [6-9][0-9]|100) ICON="󰕾"; LABEL="$DEVICE  $VOLUME%"
  ;;
  [3-5][0-9]) ICON="󰖀"; LABEL="$DEVICE  $VOLUME%"
  ;;
  [1-9]|[1-2][0-9]) ICON="󰕿"; LABEL="$DEVICE  $VOLUME%"
  ;;
  0) ICON="󰖁"; LABEL="$DEVICE  $VOLUME%"
  ;;
  *) ICON="󰕾"; LABEL="$DEVICE"  # non-adjustable device (no software volume)
esac

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
