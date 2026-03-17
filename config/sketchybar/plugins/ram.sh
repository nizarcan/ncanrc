#!/usr/bin/env bash

TOTAL=$(sysctl -n hw.memsize)
PAGE_SIZE=$(vm_stat | head -1 | grep -oE '[0-9]+')
ACTIVE=$(vm_stat | awk '/Pages active/ {print int($NF)}')
WIRED=$(vm_stat | awk '/Pages wired/ {print int($NF)}')
SPECULATIVE=$(vm_stat | awk '/Pages speculative/ {print int($NF)}')
COMPRESSED=$(vm_stat | awk '/Pages occupied by compressor/ {print int($NF)}')

USED=$(( (ACTIVE + WIRED + SPECULATIVE + COMPRESSED) * PAGE_SIZE ))
PCT=$(( USED * 100 / TOTAL ))

sketchybar --set "$NAME" label="${PCT}%"
