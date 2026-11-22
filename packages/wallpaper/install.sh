#!/usr/bin/env bash
# Wallpaper: Catppuccin Mocha mountains.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "wallpaper"

# Linked where System Settings' file picker finds it; setting it as the wallpaper
# is done by hand (see README).
_dot_link "${DOT_PACKAGE_DIR}/config/catppuccin-mountains.jpg" \
    "${HOME}/Pictures/Wallpapers/catppuccin-mountains.jpg"

_dot_ok "wallpaper linked (set it by hand, see packages/wallpaper/README.md)"
