#!/usr/bin/env bash
# Chrome DevTools MCP: lets Claude Code drive Chrome (navigate, click, screenshots).
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "chrome-devtools-mcp (uninstall)"

desktop_config="${HOME}/Library/Application Support/Claude/claude_desktop_config.json"
if command -v jq >/dev/null && [ -f "${desktop_config}" ] \
    && jq -e '.mcpServers["chrome-devtools"] != null' "${desktop_config}" >/dev/null; then
    tmp="$(mktemp "${desktop_config}.XXXXXX")"
    jq 'del(.mcpServers["chrome-devtools"])' "${desktop_config}" > "${tmp}"
    mv "${tmp}" "${desktop_config}"
fi

if command -v claude >/dev/null && claude mcp get chrome-devtools >/dev/null 2>&1; then
    claude mcp remove --scope user chrome-devtools >/dev/null
fi
if command -v mise >/dev/null; then
    mise uninstall --all npm:chrome-devtools-mcp
fi
_dot_unlink "${DOT_PACKAGE_DIR}/config/mise.toml" "${HOME}/.config/mise/conf.d/chrome-devtools-mcp.toml"

_dot_ok "chrome-devtools-mcp uninstalled"
