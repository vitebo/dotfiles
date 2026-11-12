#!/usr/bin/env bash

# dotfiles: shows AeroSpace's binding mode while it isn't "main" (eg "service"),
# in place of the focused app (front_app is hidden meanwhile). Run on
# aerospace_mode_change and on the first run.

MODE="$(aerospace list-modes --current)"

if [ "$MODE" = "main" ]; then
    sketchybar --set $NAME drawing=off --set front_app drawing=on
else
    sketchybar --set $NAME drawing=on label="$MODE" --set front_app drawing=off
fi
