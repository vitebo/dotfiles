#!/usr/bin/env bash
# ~/.claude/statusline.sh -> 21-any-claude-code/config/statusline.sh
#
# Claude Code's status line: prints the plan usage (5-hour and 7-day windows).
# Claude Code sends `rate_limits` on stdin only for claude.ai subscriptions, after
# the session's first response; without it, nothing is printed.
# Docs: https://code.claude.com/docs/en/statusline.md
set -euo pipefail

jq -r '.rate_limits // empty | [
    (.five_hour.used_percentage // empty | "5h \(round)%"),
    (.seven_day.used_percentage // empty | "7d \(round)%")
] | join(" · ")' 2>/dev/null || true
