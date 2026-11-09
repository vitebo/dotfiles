#!/usr/bin/env bash

# dotfiles: AWS Client VPN (52-mac-aws-vpn-client) state, in the bar's Catppuccin
# colors (colors.sh). The client logs each change of its tray state ("Tray state
# changed to connected") to ~/.config/AWSVPNClient/logs, one file per day; the
# last one logged is the current state:
# - client closed, or disconnected: dimmed icon;
# - connecting: dimmed icon with "…";
# - connected: icon only.

source "$CONFIG_DIR/colors.sh"

LOG_DIR="$HOME/.config/AWSVPNClient/logs"

STATE=""
if pgrep -xq "AWS VPN Client" && [ -d "$LOG_DIR" ]; then
    STATE="$(ls -tr "$LOG_DIR"/*.log 2>/dev/null | tr '\n' '\0' \
        | xargs -0 grep -h -o 'Tray state changed to [a-z]*' 2>/dev/null \
        | tail -1 | awk '{print $NF}')"
fi

case "$STATE" in
    connected)
        sketchybar --set "$NAME" icon.color=$TEXT_COLOR label.drawing=off
        ;;
    connecting|reconnecting)
        sketchybar --set "$NAME" icon.color=$DIMMED_COLOR \
            label="…" label.color=$DIMMED_COLOR label.drawing=on
        ;;
    *)
        sketchybar --set "$NAME" icon.color=$DIMMED_COLOR label.drawing=off
        ;;
esac
