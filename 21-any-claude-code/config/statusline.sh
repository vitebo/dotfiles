#!/usr/bin/env bash
# ~/.claude/statusline.sh -> 21-any-claude-code/config/statusline.sh
#
# Claude Code's status line, styled after cc-hud (https://github.com/WaterTian/cc-hud):
#   context bar │ 5h usage (reset) │ 7d usage (reset) │ git branch
# Everything comes from the JSON Claude Code sends on stdin, plus git for the branch.
# `rate_limits` only comes for claude.ai subscriptions, after the session's first
# response; segments without data are dropped.
# Colors are the 16 ANSI ones, so they follow the terminal's Catppuccin palette.
# Docs: https://code.claude.com/docs/en/statusline.md
set -euo pipefail

input=$(cat)

branch=""
cwd=$(jq -r '.cwd // empty' <<<"$input")
if [[ -n "$cwd" ]] && branch=$(git -C "$cwd" symbolic-ref --short -q HEAD 2>/dev/null); then
  # --no-optional-locks: never take index.lock while the session runs git
  if [[ -n $(git -C "$cwd" --no-optional-locks status --porcelain --untracked-files=no 2>/dev/null) ]]; then
    branch+="*"
  fi
fi

jq -r --arg branch "$branch" '
  def paint(code; s): "\u001b[\(code)m\(s)\u001b[0m";
  def dim(s): paint(90; s);
  def level(p): if p <= 50 then 32 elif p <= 85 then 33 else 31 end;
  def clamp: [[., 0] | max, 100] | min;

  def bar(p):
    if p == null then dim("░" * 10) + " " + dim("—%")
    else (p | clamp) as $p
      | ($p / 10) as $t | ($t | floor) as $full | (($t - $full) * 8 | round) as $frac
      | ([" ", "▏", "▎", "▍", "▌", "▋", "▊", "▉", "█"][$frac]) as $part
      | (10 - $full - (if $frac > 0 then 1 else 0 end)) as $empty
      | paint(level($p); "█" * $full + (if $frac > 0 then $part else "" end))
        + dim("░" * $empty) + " " + paint(level($p); "\($p | round)%")
    end;

  def countdown(r):
    if r == null or r <= now then ""
    else ((r - now) / 60) as $m
      | (if $m < 60 then "\($m | round)m"
         elif $m < 1440 then "\($m / 60 * 10 | round / 10)h"
         else "\($m / 1440 * 10 | round / 10)d" end) as $t
      | " " + dim("(") + paint(36; $t) + dim(")")
    end;

  def rate(name):
    (.used_percentage // empty | clamp | round) as $p
    | dim("\(name):") + paint(level($p); "\($p)%") + countdown(.resets_at);

  [ bar(.context_window.used_percentage),
    (.rate_limits.five_hour // empty | rate("5h")),
    (.rate_limits.seven_day // empty | rate("7d")),
    ($branch | select(. != "") | paint(32; .))
  ] | join(" " + dim("│") + " ")
' <<<"$input"
