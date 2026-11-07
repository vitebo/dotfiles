#!/usr/bin/env bash
# tmux: terminal multiplexer.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "tmux"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_link "${DOT_PACKAGE_DIR}/config/tmux.conf" "${HOME}/.config/tmux/tmux.conf"
# Also ~/.tmux.conf, which tmux reads instead of the XDG one when it exists: tools
# writing to it (eg OpenRig's `rig setup`) then edit this file rather than shadowing it.
_dot_link "${DOT_PACKAGE_DIR}/config/tmux.conf" "${HOME}/.tmux.conf"
_dot_link "${DOT_PACKAGE_DIR}/config/status-line.conf" "${HOME}/.config/tmux/status-line.conf"
_dot_link_zsh "${DOT_PACKAGE_DIR}/config/tmux.zsh"

_dot_ok "tmux installed"
