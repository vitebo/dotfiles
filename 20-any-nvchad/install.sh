#!/usr/bin/env bash
# NvChad: Neovim configuration.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "nvchad"
_dot_require git cc make unzip rg tree-sitter nvim

_dot_link "${DOT_PACKAGE_DIR}/config/nvim" "${HOME}/.config/nvim"

# Installs the plugins pinned in lazy-lock.json, so the first launch is ready to use.
nvim --headless "+Lazy! restore" +qa

_dot_ok "nvchad installed"
