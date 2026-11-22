#!/usr/bin/env bash
# delta: syntax-highlighting pager for git.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "git-delta (uninstall)"

_dot_unlink "${DOT_PACKAGE_DIR}/config/git-delta.config" "${HOME}/.config/git-delta/git-delta.config"

_dot_select_package_manager || true
_dot_uninstall_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "git-delta uninstalled"
