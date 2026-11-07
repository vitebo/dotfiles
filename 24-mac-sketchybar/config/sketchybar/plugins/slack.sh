#!/usr/bin/env bash

# dotfiles: Slack (38-mac-slack) state from its Dock badge,
# styled with our neutral palette (active: light on #414550):
# - Slack closed: dimmed icon;
# - nothing unread: icon only;
# - unread channels only (badge "•"): the dot, not highlighted;
# - mentions / direct messages (badge is a number): the number, highlighted.

ACTIVE_FG=0xffe2e2e3
ACTIVE_BG=0xff414550
NORMAL=0xffffffff
DIMMED=0x66ffffff

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
