#!/usr/bin/env bash
# fd: simple, fast alternative to find.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "fd (uninstall)"

_dot_unlink_zsh "${DOT_PACKAGE_DIR}/config/30-fd.zsh"

_dot_select_package_manager || true
_dot_uninstall_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "fd uninstalled"
