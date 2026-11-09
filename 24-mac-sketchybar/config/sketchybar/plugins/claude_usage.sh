#!/usr/bin/env bash

# dotfiles: Claude Code plan usage, saved by its status line (21-any-claude-code,
# config/statusline.sh) to ~/.cache/claude-code/usage.json, in the bar's Catppuccin
# colors (colors.sh): "<5-hour> · <7-day>" percentages. A window whose resets_at has
# passed counts as 0% (it was reset, Claude Code just hasn't sent new data yet).
# - no usage saved (no subscription / Claude Code not used yet): hidden;
# - either window at 80% or more: highlighted;
# - otherwise: normal text.

source "$CONFIG_DIR/colors.sh"

USAGE_FILE="$HOME/.cache/claude-code/usage.json"

if [ ! -f "$USAGE_FILE" ]; then
    sketchybar --set "$NAME" drawing=off
    exit 0
fi

read -r FIVE SEVEN < <(jq -r --argjson now "$(date +%s)" '
    def pct(w): if w == null or (w.resets_at // 0) <= $now then 0 else (w.used_percentage | round) end;
    "\(pct(.five_hour)) \(pct(.seven_day))"' "$USAGE_FILE" 2>/dev/null)

if [ -z "${FIVE:-}" ]; then
    sketchybar --set "$NAME" drawing=off
    exit 0
fi

LABEL="${FIVE}% · ${SEVEN}%"

if [ "$FIVE" -ge 80 ] || [ "$SEVEN" -ge 80 ]; then
    sketchybar --set "$NAME" drawing=on label="$LABEL" \
        icon.color=$ACTIVE_FG label.color=$ACTIVE_FG \
        background.color=$ACTIVE_BG background.drawing=on
else
    sketchybar --set "$NAME" drawing=on label="$LABEL" \
        icon.color=$TEXT_COLOR label.color=$TEXT_COLOR background.drawing=off
fi
