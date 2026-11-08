#!/usr/bin/env bash

# dotfiles: Slack (38-mac-slack) state from its Dock badge, in the bar's
# Catppuccin colors (colors.sh):
# - Slack closed: dimmed icon;
# - nothing unread: icon only;
# - unread channels only (badge "•"): the dot, not highlighted;
# - mentions / direct messages (badge is a number): the number, highlighted.

source "$CONFIG_DIR/colors.sh"
NORMAL=$TEXT_COLOR
DIMMED=$DIMMED_COLOR

if ! pgrep -xq Slack; then
    sketchybar --set "$NAME" icon.color=$DIMMED label.drawing=off background.drawing=off
    exit 0
fi

LABEL="$(lsappinfo info -only StatusLabel Slack | sed -n 's/.*"label"="\(.*\)".*/\1/p')"

case "$LABEL" in
    "")
        sketchybar --set "$NAME" icon.color=$NORMAL label.drawing=off background.drawing=off
        ;;
    [0-9]*)
        sketchybar --set "$NAME" icon.color=$ACTIVE_FG \
            label="$LABEL" label.color=$ACTIVE_FG label.drawing=on \
            background.color=$ACTIVE_BG background.drawing=on
        ;;
    *)
        sketchybar --set "$NAME" icon.color=$NORMAL \
            label="$LABEL" label.color=$NORMAL label.drawing=on background.drawing=off
        ;;
esac
