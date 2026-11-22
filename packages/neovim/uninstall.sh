#!/usr/bin/env bash
# Neovim: text editor.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "neovim (uninstall)"

_dot_unlink_zsh "${DOT_PACKAGE_DIR}/config/17-neovim.zsh"

_dot_select_package_manager || true
_dot_uninstall_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "neovim uninstalled"
