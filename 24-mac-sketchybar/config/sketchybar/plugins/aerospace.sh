#!/usr/bin/env bash

# dotfiles: from AeroSpace's SketchyBar integration
# (https://nikitabobko.github.io/AeroSpace/goodies), replaces space.sh.
# Highlights the item of the focused AeroSpace workspace ($1 is its id).
# dotfiles: and dims the ones without windows.

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

# dotfiles: dim the number of workspaces without windows.
source "$CONFIG_DIR/colors.sh"
if [ "$(aerospace list-windows --workspace "$1" --count)" -gt 0 ]; then
    sketchybar --set $NAME label.color=$TEXT_COLOR
else
    sketchybar --set $NAME label.color=$DIMMED_COLOR
fi
