#!/usr/bin/env bash
# bat: cat clone with syntax highlighting.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "bat"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_link "${DOT_PACKAGE_DIR}/config/config" "${HOME}/.config/bat/config"
_dot_link_zsh "${DOT_PACKAGE_DIR}/config/28-bat.zsh"

_dot_ok "bat installed"
