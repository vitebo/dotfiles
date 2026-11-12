#!/usr/bin/env bash

# dotfiles: shows AeroSpace's binding mode while it isn't "main" (eg "service"),
# hidden otherwise. Run on aerospace_mode_change and on the first run.

MODE="$(aerospace list-modes --current)"

if [ "$MODE" = "main" ]; then
    sketchybar --set $NAME drawing=off
else
    sketchybar --set $NAME drawing=on label="$MODE"
fi
