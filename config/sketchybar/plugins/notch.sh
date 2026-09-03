#!/bin/sh

# Toggle the notch spacer that splits the clock (date | notch | time).
# Reserve the notch gap only when the built-in (notched) display is active;
# collapse it to 0 otherwise (e.g. clamshell on an external monitor) so the
# date and time sit together in the center.

BUILTIN_HEIGHT=1117

HEIGHT=$(osascript -e 'tell application "Finder" to get bounds of window of desktop' 2>/dev/null | awk -F', ' '{print $4}')

if [ "$HEIGHT" = "$BUILTIN_HEIGHT" ]; then
  sketchybar --set "$NAME" width=180
else
  sketchybar --set "$NAME" width=0
fi
