#!/usr/bin/env bash
# lazydocker: terminal UI for docker and docker compose.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "lazydocker"
_dot_require docker
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_link "${DOT_PACKAGE_DIR}/config/config.yml" "${HOME}/.config/lazydocker/config.yml"
_dot_link_zsh "${DOT_PACKAGE_DIR}/config/42-lazydocker.zsh"

_dot_ok "lazydocker installed"
