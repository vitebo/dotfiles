#!/usr/bin/env bash
# Homebrew: macOS package manager.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "homebrew (uninstall)"

_dot_unlink_zsh "${DOT_PACKAGE_DIR}/config/01-homebrew.zsh"

# Official uninstaller: removes Homebrew and everything installed with it,
# including packages that don't come from the dotfiles.
if _dot_select_package_manager && [ "${DOT_PM}" = "brew" ]; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
fi

_dot_ok "homebrew uninstalled"
