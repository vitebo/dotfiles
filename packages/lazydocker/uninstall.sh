#!/usr/bin/env bash
# lazydocker: terminal UI for docker and docker compose.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "lazydocker (uninstall)"

_dot_unlink_zsh "${DOT_PACKAGE_DIR}/config/42-lazydocker.zsh"
_dot_unlink "${DOT_PACKAGE_DIR}/config/config.yml" "${HOME}/.config/lazydocker/config.yml"

_dot_select_package_manager || true
_dot_uninstall_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "lazydocker uninstalled"
