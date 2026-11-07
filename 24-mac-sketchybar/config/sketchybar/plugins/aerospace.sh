#!/usr/bin/env bash

# dotfiles: from AeroSpace's SketchyBar integration
# (https://nikitabobko.github.io/AeroSpace/goodies), replaces space.sh.
# Highlights the item of the focused AeroSpace workspace ($1 is its id).

# dotfiles: on the first run (`sketchybar --update`) there's no workspace change
# event yet, so ask AeroSpace for the focused workspace.
if [ -z "$FOCUSED_WORKSPACE" ]; then
    FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"
fi

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on
else
    sketchybar --set $NAME background.drawing=off
fi
