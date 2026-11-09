#!/usr/bin/env bash

# dotfiles: AWS Client VPN (52-mac-aws-vpn-client) state, in the bar's Catppuccin
# colors (colors.sh). The client logs each change of its tray state ("Tray state
# changed to connected") to ~/.config/AWSVPNClient/logs, one file per day; the
# last one logged is the current state:
# - client closed, or disconnected: crossed-out cloud (nf-md-cloud_off_outline), dimmed;
# - connecting: cloud outline (nf-md-cloud_outline), dimmed, with "…";
# - connected: cloud with a lock (nf-md-cloud_lock).

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
        sketchybar --set "$NAME" icon=󱇱 icon.color=$TEXT_COLOR label.drawing=off
        ;;
    connecting|reconnecting)
        sketchybar --set "$NAME" icon=󰅣 icon.color=$DIMMED_COLOR \
            label="…" label.color=$DIMMED_COLOR label.drawing=on
        ;;
    *)
        sketchybar --set "$NAME" icon=󰅤 icon.color=$DIMMED_COLOR label.drawing=off
        ;;
esac
