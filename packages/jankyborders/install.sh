#!/usr/bin/env bash
# JankyBorders: colored border around the focused window.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "jankyborders"
_dot_require aerospace
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_link "${DOT_PACKAGE_DIR}/config/bordersrc" "${HOME}/.config/borders/bordersrc"

_dot_ok "jankyborders installed"
