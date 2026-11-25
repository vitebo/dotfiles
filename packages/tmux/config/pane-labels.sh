#!/usr/bin/env bash
# ~/.config/tmux/pane-labels.sh -> packages/tmux/config/pane-labels.sh
#
# Shows the pane labels (status-line.conf, pane-border-status) only in windows
# with more than one pane, so windows without splits keep every line. Run by
# tmux's hooks whenever panes come and go (tmux.conf). Every window is checked,
# not just the hook's: on kill-pane / pane-exited the hook runs before the pane
# is gone and in the current window's context.
set -euo pipefail

tmux list-windows -a -F '#{window_id} #{?#{>:#{window_panes},1},top,off} #{pane-border-status}' |
    while read -r window wanted current; do
        if [ "${wanted}" != "${current}" ]; then
            tmux set-option -w -t "${window}" pane-border-status "${wanted}"
        fi
    done
