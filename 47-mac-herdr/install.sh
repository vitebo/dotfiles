#!/usr/bin/env bash
# herdr: terminal workspace manager for AI coding agents.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "herdr"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_link "${DOT_PACKAGE_DIR}/config/config.toml" "${HOME}/.config/herdr/config.toml"

# Claude Code integration's hook (what `herdr integration install claude` writes),
# called by ~/.claude/settings.json (21-any-claude-code) only when this file exists.
_dot_link "${DOT_PACKAGE_DIR}/config/claude-hook.sh" "${HOME}/.claude/hooks/herdr-agent-state.sh"

_dot_ok "herdr installed"
