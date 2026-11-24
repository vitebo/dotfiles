#!/usr/bin/env bash
# Claude Desktop: Claude's desktop app.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "claude-desktop"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "claude-desktop installed"
