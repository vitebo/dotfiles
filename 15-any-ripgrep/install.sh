#!/usr/bin/env bash
# ripgrep (rg): fast recursive search.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "ripgrep"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "ripgrep installed"
