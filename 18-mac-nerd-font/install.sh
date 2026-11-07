#!/usr/bin/env bash
# Nerd Font: patched font with icons, used by the terminal.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "nerd-font"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "nerd-font installed"
