#!/usr/bin/env bash
# Homebrew: macOS package manager.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "homebrew"

if ! _dot_select_package_manager; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

_dot_link_zsh "${DOT_PACKAGE_DIR}/config/homebrew.zsh"

_dot_ok "homebrew installed"
