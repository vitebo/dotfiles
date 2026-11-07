#!/usr/bin/env bash
# OpenRig: teams of coding agents (Claude Code...) running in tmux / herdr.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "openrig"
_dot_require mise tmux claude

_dot_link "${DOT_PACKAGE_DIR}/config/mise.toml" "${HOME}/.config/mise/conf.d/openrig.toml"
_dot_link_zsh "${DOT_PACKAGE_DIR}/config/openrig.zsh"

# Installs the CLI declared above; already installed versions are skipped.
mise install --yes

_dot_ok "openrig installed"
