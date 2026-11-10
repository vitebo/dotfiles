#!/usr/bin/env bash
# ~/.claude/statusline.sh -> 21-any-claude-code/config/statusline.sh
#
# Claude Code's status line, styled after cc-hud (https://github.com/WaterTian/cc-hud):
#   context bar │ 5h usage (reset) │ 7d usage (reset) │ effort level
# Everything comes from the JSON Claude Code sends on stdin.
# `rate_limits` only comes for claude.ai subscriptions, after the session's first
# response, and `effort` only for models with effort levels; segments without data
# are dropped.
# Colors are the 16 ANSI ones, so they follow the terminal's Catppuccin palette.
# Docs: https://code.claude.com/docs/en/statusline.md
set -euo pipefail

# Blank-looking lines around the status line leave a small gap above and below it.
# They hold a braille blank (U+2800): Claude Code drops lines made of whitespace only.
gap="⠀"

echo "$gap"
jq -r '
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

  # Claude Code drops a window once it resets, until the next response brings the
  # new one: show it as —% meanwhile instead of hiding it.
  def rate(icon; name):
    if .used_percentage == null then dim("\(icon) \(name):—%")
    else (.used_percentage | clamp | round) as $p
      | dim("\(icon) \(name):") + paint(level($p); "\($p)%") + countdown(.resets_at)
    end;

  [ dim("󰧑") + "  " + bar(.context_window.used_percentage),  # brain (\U000F09D1)
    (.rate_limits // empty | .five_hour | rate("󰔟"; "5h")),   # timer sand (\U000F051F)
    (.rate_limits // empty | .seven_day | rate("󰃭"; "7d")),   # calendar (\U000F00ED)
    (.effort.level // empty | dim("󰓅 ") + paint(35; .))       # speedometer (\U000F04C5)
  ] | join(" " + dim("│") + " ")
'
echo "$gap"
