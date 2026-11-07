#!/usr/bin/env bash

# dotfiles: number of unread Slack direct messages (Slack's Dock badge), like
# gnugat's slack item; empty when Slack isn't running or nothing is unread.

LABEL="$(lsappinfo info -only StatusLabel Slack | sed -n 's/.*"label"="\(.*\)".*/\1/p')"

if [ -n "$LABEL" ]; then
    sketchybar --set "$NAME" label="$LABEL" label.drawing=on
else
    sketchybar --set "$NAME" label.drawing=off
fi
