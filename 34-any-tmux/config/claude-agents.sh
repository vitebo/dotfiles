#!/usr/bin/env bash
# ~/.config/tmux/claude-agents.sh -> 34-any-tmux/config/claude-agents.sh
#
# `prefix + a` (tmux.conf): a menu with every tmux pane running Claude Code, the
# ones that need you first, each with its state icon (claude-hook.sh), session and
# Claude's session title; picking one (or its number) jumps there.
#
# Usage: claude-agents.sh <client>
set -euo pipefail

# Fields are split on \x1f, not tabs: empty fields (eg no state yet) would collapse.
SEP=$'\x1f'
# Counts characters, not bytes, when cutting titles (run-shell may have no locale).
export LC_CTYPE=UTF-8

client="${1:-}"

ICON_attention=$'\xf3\xb0\x82\x9e'  # bell: needs you
ICON_done=$'\xf3\xb0\x84\xac'       # check: done, not read yet
ICON_read=$'\xf3\xb0\x84\xad'       # double check: done, read
ICON_working=$'\xf3\xb0\x94\x9f'    # hourglass: working
ICON_none=$'\xf3\xb0\xa7\x9f'       # dot: no state yet (no hook ran since it started)

# Whether the process $1, or one of its children, is Claude Code.
runs_claude() {
    [ "$(ps -o comm= -p "$1" 2>/dev/null)" = claude ] || pgrep -aqx -P "$1" claude
}

# One line per Claude pane: rank, icon, location (session + window), title,
# session, window and pane ids.
rows=""
width=0
while IFS="$SEP" read -r pane_id pane_pid session_id window_id session window state title; do
    runs_claude "$pane_pid" || continue
    case "$state" in
        attention) rank=1 ;; done) rank=2 ;; working) rank=3 ;; read) rank=4 ;; *) rank=5; state=none ;;
    esac
    icon_var="ICON_${state}"
    # Claude prefixes its title with a status glyph (✳ idle, a spinner while working).
    [ "${title:1:1}" != " " ] || title="${title:2}"
    [ "${#title}" -le 40 ] || title="${title:0:39}…"
    location="${session} ${window}"
    [ "${#location}" -le "$width" ] || width="${#location}"
    rows+="${rank}${SEP}${!icon_var}${SEP}${location}${SEP}${title}${SEP}${session_id}${SEP}${window_id}${SEP}${pane_id}"$'\n'
done < <(tmux list-panes -a -F "#{pane_id}${SEP}#{pane_pid}${SEP}#{session_id}${SEP}#{window_id}${SEP}\
#{session_name}${SEP}#{window_index}:#{window_name}${SEP}#{@claude_pane}${SEP}#{pane_title}")

if [ -z "$rows" ]; then
    tmux display-message ${client:+-c "$client"} "No Claude Code agents running"
    exit 0
fi

menu=()
n=0
while IFS="$SEP" read -r _rank icon location title session_id window_id pane_id; do
    n=$((n + 1))
    label="$(printf '%s  %-*s  %s' "$icon" "$width" "$location" "$title")"
    key=""
    [ "$n" -gt 9 ] || key="$n"
    # `#` starts a format in menu labels, so titles keep a literal one as `##`.
    menu+=("${label//#/##}" "$key" \
        "switch-client -t '$session_id' ; select-window -t '$window_id' ; select-pane -t '$pane_id'")
done < <(sort -t "$SEP" -k1,1n -s <<<"${rows%$'\n'}")

tmux display-menu ${client:+-c "$client"} -T "#[align=centre] Claude agents " -x C -y C "${menu[@]}"
