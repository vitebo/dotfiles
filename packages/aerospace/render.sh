#!/usr/bin/env bash
# Renders ~/.config/aerospace/aerospace.toml from config/aerospace.toml with this
# device's profile values (the profile saved by install.sh). Run by install.sh and
# by the service mode's `esc`, which then reloads AeroSpace.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_profile_export_saved
export DOT_ROOT
export DOT_AEROSPACE_GAP_TOP_BUILTIN="${DOT_AEROSPACE_GAP_TOP_BUILTIN:-22}"
_dot_render "${DOT_PACKAGE_DIR}/config/aerospace.toml" "${HOME}/.config/aerospace/aerospace.toml"
