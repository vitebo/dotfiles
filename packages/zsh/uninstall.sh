#!/usr/bin/env bash
# zsh: default shell.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "zsh (uninstall)"
_dot_detect_os

# On linux, back to bash as the default shell before removing zsh.
if [ "${DOT_OS}" = "linux" ]; then
    user="$(id -un)"
    if [ "$(basename "$(getent passwd "${user}" | cut -d: -f7)")" = "zsh" ]; then
        _dot_sudo chsh -s /bin/bash "${user}" \
            || _dot_warn "Could not change default shell to /bin/bash"
    fi
fi

_dot_unlink_zsh "${DOT_PACKAGE_DIR}/config/10-xdg.zsh"
_dot_unlink "${DOT_PACKAGE_DIR}/config/zshrc" "${HOME}/.zshrc"

_dot_select_package_manager || true
_dot_uninstall_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "zsh uninstalled"
