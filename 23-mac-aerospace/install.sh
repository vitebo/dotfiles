#!/usr/bin/env bash
# AeroSpace: i3-like tiling window manager.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "aerospace"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_link "${DOT_PACKAGE_DIR}/config/aerospace.toml" "${HOME}/.config/aerospace/aerospace.toml"

_dot_ok "aerospace installed"
