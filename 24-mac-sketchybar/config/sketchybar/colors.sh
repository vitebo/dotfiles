#!/usr/bin/env bash
# dotfiles: the bar's colors, Catppuccin Latte in light mode and Mocha in dark mode
# (CLAUDE.md "Themes"), read from the macOS appearance: AppleInterfaceStyle is
# "Dark" in dark mode and unset in light mode. Sourced by sketchybarrc and the
# plugins; the bar reloads when the appearance changes (plugins/appearance.sh).
# Colors are 0xAARRGGBB.

if [ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" = "Dark" ]; then
    # Mocha
    BAR_COLOR=0xcc181825     # mantle, translucent (the bar blurs what's behind)
    POPUP_COLOR=0xff1e1e2e   # base: popup menus
    TEXT_COLOR=0xffcdd6f4    # text
    HIGHLIGHT_COLOR=0xff45475a  # surface1: focused workspace
    ACTIVE_FG=0xff11111b     # crust, on mauve: items asking for attention
    ACTIVE_BG=0xffcba6f7     # mauve
    DIMMED_COLOR=0xff6c7086  # overlay0
else
    # Latte
    BAR_COLOR=0xcce6e9ef     # mantle, translucent
    POPUP_COLOR=0xffeff1f5   # base
    TEXT_COLOR=0xff4c4f69    # text
    HIGHLIGHT_COLOR=0xffbcc0cc  # surface1
    ACTIVE_FG=0xffeff1f5     # base, on mauve
    ACTIVE_BG=0xff8839ef     # mauve
    DIMMED_COLOR=0xff9ca0b0  # overlay0
fi
