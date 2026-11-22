#!/usr/bin/env bash
# Dev Containers CLI: starts and runs commands in projects' devcontainers.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "devcontainer"
_dot_require mise

_dot_link "${DOT_PACKAGE_DIR}/config/mise.toml" "${HOME}/.config/mise/conf.d/devcontainer.toml"

# Installs the CLI declared above; already installed versions are skipped.
mise install --yes

_dot_ok "devcontainer installed"
