#!/usr/bin/env bash
# AeroSpace: i3-like tiling window manager.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "aerospace"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

# Rendered, not linked: the top gap of built-in displays differs per device
# (see aerospace.toml) and AeroSpace can't include another file. Profiles of
# devices without a notch set it (eg `profiles/studio`).
bash "${DOT_PACKAGE_DIR}/render.sh"

_dot_ok "aerospace installed"
