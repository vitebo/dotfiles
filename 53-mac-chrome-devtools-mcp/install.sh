#!/usr/bin/env bash
# Chrome DevTools MCP: lets Claude Code drive Chrome (navigate, click, screenshots).
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "chrome-devtools-mcp"
_dot_require mise claude

_dot_link "${DOT_PACKAGE_DIR}/config/mise.toml" "${HOME}/.config/mise/conf.d/chrome-devtools-mcp.toml"

# Installs the server declared above; already installed versions are skipped.
mise install --yes

# User-scope MCP servers only live in ~/.claude.json (account state, not
# versioned), so the server is registered there with Claude Code's own CLI.
# The mise shim works whatever PATH Claude Code was started with.
if ! claude mcp get chrome-devtools >/dev/null 2>&1; then
    claude mcp add --scope user chrome-devtools -- \
        "${HOME}/.local/share/mise/shims/chrome-devtools-mcp"
fi

_dot_ok "chrome-devtools-mcp installed"
