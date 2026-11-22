#!/usr/bin/env bash
# Wallpaper: Catppuccin Mocha mountains.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "wallpaper (uninstall)"

_dot_unlink "${DOT_PACKAGE_DIR}/config/catppuccin-mountains.jpg" \
    "${HOME}/Pictures/Wallpapers/catppuccin-mountains.jpg"

_dot_ok "wallpaper uninstalled"
