#!/usr/bin/env bash

# dotfiles: when macOS switches between light and dark mode, reload the bar (its
# colors come from colors.sh) and recolor JankyBorders (25-mac-jankyborders, whose
# bordersrc reads the appearance too) when it's running.
# Only on the event: `sketchybar --update` also runs this script, and reloading
# from there would loop.

[ "$SENDER" = "appearance_changed" ] || exit 0

sketchybar --reload
if pgrep -xq borders && [ -x "$HOME/.config/borders/bordersrc" ]; then
    "$HOME/.config/borders/bordersrc"
fi
