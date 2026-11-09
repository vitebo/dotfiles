#!/usr/bin/env bash
# ~/.claude/statusline.sh -> 21-any-claude-code/config/statusline.sh
#
# Claude Code's status line: prints the plan usage (5-hour and 7-day windows) and
# saves it to ~/.cache/claude-code/usage.json, so tools outside Claude Code can show
# it (SketchyBar, 24-mac-sketchybar). Claude Code sends `rate_limits` on stdin only
# for claude.ai subscriptions, after the session's first response; without it,
# nothing is printed and the saved usage is left as is.
# Docs: https://code.claude.com/docs/en/statusline.md
set -euo pipefail

input="$(cat)"
limits="$(jq -c '.rate_limits // empty | {five_hour, seven_day}' <<<"$input" 2>/dev/null || true)"
[ -n "$limits" ] || exit 0

cache_dir="$HOME/.cache/claude-code"
mkdir -p "$cache_dir"
jq -c --argjson now "$(date +%s)" '. + {updated_at: $now}' <<<"$limits" >"$cache_dir/usage.json.tmp"
mv "$cache_dir/usage.json.tmp" "$cache_dir/usage.json"

# Tells SketchyBar to refresh right away, when it's running.
if command -v sketchybar >/dev/null 2>&1; then
    sketchybar --trigger claude_usage_changed >/dev/null 2>&1 || true
fi

jq -r '[
    (.five_hour.used_percentage // empty | "5h \(round)%"),
    (.seven_day.used_percentage // empty | "7d \(round)%")
] | join(" · ")' <<<"$limits"
