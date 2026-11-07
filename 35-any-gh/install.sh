#!/usr/bin/env bash
# gh: GitHub's command line tool.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "gh"
_dot_require git
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

# File by file: ~/.config/gh also holds hosts.yml, the per machine login.
_dot_link "${DOT_PACKAGE_DIR}/config/config.yml" "${HOME}/.config/gh/config.yml"
_dot_link "${DOT_PACKAGE_DIR}/config/git-credential.config" "${HOME}/.config/gh/git-credential.config"
_dot_link_zsh "${DOT_PACKAGE_DIR}/config/gh.zsh"

_dot_ok "gh installed"
