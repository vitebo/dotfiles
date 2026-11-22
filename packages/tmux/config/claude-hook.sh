#!/usr/bin/env bash
# ~/.claude/hooks/tmux-agent-state.sh -> packages/tmux/config/claude-hook.sh
#
# Records the state of the Claude Code session running in a tmux pane, so the
# status line can highlight windows / sessions that need you and `prefix + a` can
# list them. Called by:
# - Claude Code's hooks (claude-code's settings.json), for the pane in
#   $TMUX_PANE: claude-hook.sh working|attention|done|clear
# - tmux's pane-focus-in hook (tmux.conf), when you look at a pane:
#   claude-hook.sh read <pane>, which turns `done` into `read`.
# A turn that ends while you're looking at its pane is `read` right away.
#
# State goes in user options, one name per level (a format looking up `@x` falls
# back from pane to window to session options, so levels can't share a name):
# - @claude_pane: the pane's state;
# - @claude_window / @claude_session: the most urgent state among their panes /
#   windows (attention > done > working > read).
# Does nothing outside tmux.
set -euo pipefail

state="${1:-}"
pane="${2:-}"

if [ -z "$pane" ]; then
    cat >/dev/null || true  # the Claude Code hook's JSON input, unused
    [ -n "${TMUX:-}" ] && [ -n "${TMUX_PANE:-}" ] || exit 0
    pane="$TMUX_PANE"
fi
command -v tmux >/dev/null 2>&1 || exit 0

# Prints the most urgent state among the lines on stdin (empty when none).
most_urgent() {
    local states
    states="$(cat)"
    for s in attention done working read; do
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

# Whether you're looking at the pane: active in the current window of a session
# shown by a focused client.
is_watched() {
    local session
    [ "$(tmux display-message -p -t "$pane" '#{&&:#{pane_active},#{window_active}}')" = 1 ] || return 1
    session="$(tmux display-message -p -t "$pane" '#{session_name}')"
    tmux list-clients -F '#{client_session} #{client_flags}' | grep -q "^${session} .*focused"
}

case "$state" in
    working|attention) set_state -p @claude_pane "$pane" "$state" ;;
    done)
        if is_watched; then state=read; fi
        set_state -p @claude_pane "$pane" "$state"
        ;;
    read)
        [ "$(tmux show-options -pqv -t "$pane" @claude_pane)" = done ] || exit 0
        set_state -p @claude_pane "$pane" read
        ;;
    clear) set_state -p @claude_pane "$pane" "" ;;
    *) exit 0 ;;
esac

window="$(tmux display-message -p -t "$pane" '#{window_id}')"
session="$(tmux display-message -p -t "$pane" '#{session_id}')"

set_state -w @claude_window "$window" \
    "$(tmux list-panes -t "$window" -F '#{@claude_pane}' | most_urgent)"
set_state "" @claude_session "$session" \
    "$(tmux list-windows -t "$session" -F '#{@claude_window}' | most_urgent)"

# Redraws the status line of every client, without waiting for status-interval.
for client in $(tmux list-clients -F '#{client_name}'); do
    tmux refresh-client -S -t "$client" 2>/dev/null || true
done
