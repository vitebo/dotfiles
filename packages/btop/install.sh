#!/usr/bin/env bash
# btop: terminal resource monitor.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "btop"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

# File by file: ~/.config/btop also holds btop's log (btop.log).
_dot_link "${DOT_PACKAGE_DIR}/config/btop.conf" "${HOME}/.config/btop/btop.conf"

_dot_ok "btop installed"
