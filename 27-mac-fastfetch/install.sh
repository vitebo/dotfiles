#!/usr/bin/env bash
# fastfetch: system information summary.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "fastfetch"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_link "${DOT_PACKAGE_DIR}/config/config.jsonc" "${HOME}/.config/fastfetch/config.jsonc"
_dot_link_zsh "${DOT_PACKAGE_DIR}/config/fastfetch.zsh"

_dot_ok "fastfetch installed"
