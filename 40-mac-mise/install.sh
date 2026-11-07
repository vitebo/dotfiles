#!/usr/bin/env bash
# mise: polyglot runtime / tool version manager.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "mise"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_link "${DOT_PACKAGE_DIR}/config/config.toml" "${HOME}/.config/mise/config.toml"

# Installs the global tools (eg Node.js 22); already installed ones are skipped.
mise install --yes

_dot_ok "mise installed"
