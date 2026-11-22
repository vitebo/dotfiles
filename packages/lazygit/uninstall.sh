#!/usr/bin/env bash
# lazygit: terminal UI for git.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "lazygit (uninstall)"

_dot_unlink_zsh "${DOT_PACKAGE_DIR}/config/41-lazygit.zsh"
_dot_unlink "${DOT_PACKAGE_DIR}/config/delta.yml" "${HOME}/.config/lazygit/delta.yml"
_dot_unlink "${DOT_PACKAGE_DIR}/config/config.yml" "${HOME}/.config/lazygit/config.yml"

_dot_select_package_manager || true
_dot_uninstall_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "lazygit uninstalled"
