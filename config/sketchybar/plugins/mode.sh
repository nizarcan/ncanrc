#!/usr/bin/env bash

MODE="$MODE"

case "$MODE" in
    main|"")
        sketchybar --set $NAME label=""
        ;;
    service)
        sketchybar --set $NAME label="[SERVICE]" label.color=0xffffcc66
        ;;
    resize)
        sketchybar --set $NAME label="[RESIZE]" label.color=0xff66ccff
        ;;
    *)
        sketchybar --set $NAME label="[$MODE]" label.color=0xffff6666
        ;;
esac
