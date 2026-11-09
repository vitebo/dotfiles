#!/usr/bin/env bash
# ~/.claude/hooks/tmux-agent-state.sh -> 34-any-tmux/config/claude-hook.sh
#
# Claude Code hook (21-any-claude-code's settings.json): records the state of the
# Claude session running in this tmux pane, so the status line can highlight
# windows / sessions that need you and `prefix + a` can list them.
#
# Usage: claude-hook.sh working|attention|done|clear
# State goes in user options, one name per level (a format looking up `@x` falls
# back from pane to window to session options, so levels can't share a name):
# - @claude_pane: this pane's state;
# - @claude_window / @claude_session: the most urgent state among their panes /
#   windows (attention > done > working).
# Does nothing outside tmux.
set -euo pipefail

cat >/dev/null || true  # the hook's JSON input, unused
[ -n "${TMUX:-}" ] && [ -n "${TMUX_PANE:-}" ] || exit 0
command -v tmux >/dev/null 2>&1 || exit 0

state="${1:-}"

# Prints the most urgent state among the lines on stdin (empty when none).
most_urgent() {
    local states
    states="$(cat)"
    for s in attention done working; do
        if grep -qx "$s" <<<"$states"; then
            echo "$s"
            return
        fi
    done
}

# Sets option $2 on target $3 at scope $1 (-p / -w / ''), or unsets it when $4 is empty.
set_state() {
    if [ -n "$4" ]; then
        tmux set-option $1 -q -t "$3" "$2" "$4"
    else
        tmux set-option $1 -q -u -t "$3" "$2"
    fi
}

case "$state" in
    working|attention|done) set_state -p @claude_pane "$TMUX_PANE" "$state" ;;
    clear) set_state -p @claude_pane "$TMUX_PANE" "" ;;
    *) exit 0 ;;
esac

window="$(tmux display-message -p -t "$TMUX_PANE" '#{window_id}')"
session="$(tmux display-message -p -t "$TMUX_PANE" '#{session_id}')"

set_state -w @claude_window "$window" \
    "$(tmux list-panes -t "$window" -F '#{@claude_pane}' | most_urgent)"
set_state "" @claude_session "$session" \
    "$(tmux list-windows -t "$session" -F '#{@claude_window}' | most_urgent)"

# Redraws the status line of every client, without waiting for status-interval.
tmux refresh-client -S 2>/dev/null || true
for client in $(tmux list-clients -F '#{client_name}'); do
    tmux refresh-client -S -t "$client" 2>/dev/null || true
done
