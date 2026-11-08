#!/usr/bin/env bash
# Wallpaper: Catppuccin mountains, Latte in light mode and Mocha in dark mode.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "wallpaper"

# Linked where System Settings' file picker finds it; setting it as the wallpaper
# is done by hand (see README).
_dot_link "${DOT_PACKAGE_DIR}/config/catppuccin-mountains.heic" \
    "${HOME}/Pictures/Wallpapers/catppuccin-mountains.heic"

_dot_ok "wallpaper linked (set it by hand, see 49-mac-wallpaper/README.md)"
