#!/usr/bin/env bash
# mise: polyglot runtime / tool version manager.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "mise (uninstall)"

_dot_unlink "${DOT_PACKAGE_DIR}/config/config.toml" "${HOME}/.config/mise/config.toml"

_dot_select_package_manager || true
_dot_uninstall_with_package_manager "${DOT_PACKAGE_DIR}"

# Installed tools (eg Node.js) are only usable through mise.
rm -rf "${MISE_DATA_DIR:-${XDG_DATA_HOME:-${HOME}/.local/share}/mise}"

_dot_ok "mise uninstalled"
