#!/usr/bin/env bash

# dotfiles: the reload button's click: the same as AeroSpace's service mode `esc`
# (packages/aerospace), so a config change applies without the keyboard.
# AeroSpace first, then JankyBorders (packages/jankyborders; bordersrc updates it,
# or starts it when it isn't running), and the bar last, since reloading it
# restarts this item too. AeroSpace's config is rendered from the repo first
# (packages/aerospace/render.sh): this file is reached through the
# ~/.config/sketchybar symlink, so the repo is found on the physical path.

DOT_ROOT="$(cd -P "$(dirname "${BASH_SOURCE[0]}")/../../../../.." && pwd)"
bash "${DOT_ROOT}/packages/aerospace/render.sh" && aerospace reload-config
if [ -x "$HOME/.config/borders/bordersrc" ]; then
    "$HOME/.config/borders/bordersrc" &
fi
sketchybar --reload
