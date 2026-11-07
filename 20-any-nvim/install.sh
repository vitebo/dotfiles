#!/usr/bin/env bash
# Neovim with NvChad.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "nvim"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_link "${DOT_PACKAGE_DIR}/config/nvim" "${HOME}/.config/nvim"
_dot_link "${DOT_PACKAGE_DIR}/config/nvim.zsh" "${HOME}/.config/zsh/nvim.zsh"

# Installs the plugins pinned in lazy-lock.json, so the first launch is ready to use.
nvim --headless "+Lazy! restore" +qa

_dot_ok "nvim installed"
