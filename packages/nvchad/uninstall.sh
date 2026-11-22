#!/usr/bin/env bash
# NvChad: Neovim configuration.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "nvchad (uninstall)"

_dot_unlink "${DOT_PACKAGE_DIR}/config/nvim" "${HOME}/.config/nvim"
# Plugins, parsers and tools installed by lazy.nvim / mason; Neovim's state
# (shada, undo) and cache stay.
rm -rf "${XDG_DATA_HOME:-${HOME}/.local/share}/nvim"

_dot_ok "nvchad uninstalled"
