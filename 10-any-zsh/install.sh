#!/usr/bin/env bash
# zsh: default shell.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "zsh"
_dot_detect_os
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_link "${DOT_PACKAGE_DIR}/config/zshrc" "${HOME}/.zshrc"

# zsh is already the default shell on mac; on linux switch to it if needed.
if [ "${DOT_OS}" = "linux" ]; then
    zsh_path="$(command -v zsh)"
    user="$(id -un)"
    if [ "$(getent passwd "${user}" | cut -d: -f7)" != "${zsh_path}" ]; then
        _dot_sudo chsh -s "${zsh_path}" "${user}" \
            || _dot_warn "Could not change default shell to ${zsh_path}"
    fi
fi

_dot_ok "zsh installed"
