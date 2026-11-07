#!/usr/bin/env bash
# lazygit: terminal UI for git.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "lazygit"
_dot_require git
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

# File by file: ~/.config/lazygit also holds lazygit's state (state.yml).
_dot_link "${DOT_PACKAGE_DIR}/config/config.yml" "${HOME}/.config/lazygit/config.yml"
_dot_link "${DOT_PACKAGE_DIR}/config/delta.yml" "${HOME}/.config/lazygit/delta.yml"
_dot_link_zsh "${DOT_PACKAGE_DIR}/config/lazygit.zsh"

_dot_ok "lazygit installed"
