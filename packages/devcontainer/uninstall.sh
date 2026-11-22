#!/usr/bin/env bash
# Dev Containers CLI: starts and runs commands in projects' devcontainers.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "devcontainer (uninstall)"

if command -v mise >/dev/null; then
    mise uninstall --all npm:@devcontainers/cli
fi
_dot_unlink "${DOT_PACKAGE_DIR}/config/mise.toml" "${HOME}/.config/mise/conf.d/devcontainer.toml"

_dot_ok "devcontainer uninstalled"
