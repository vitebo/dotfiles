#!/usr/bin/env bash
# Chrome DevTools MCP: lets Claude Code drive Chrome (navigate, click, screenshots).
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "chrome-devtools-mcp"
_dot_require mise claude jq

_dot_link "${DOT_PACKAGE_DIR}/config/mise.toml" "${HOME}/.config/mise/conf.d/chrome-devtools-mcp.toml"

# Installs the server declared above; already installed versions are skipped.
mise install --yes

# User-scope MCP servers only live in ~/.claude.json (account state, not
# versioned), so the server is registered there with Claude Code's own CLI, and
# registered again when its arguments changed. The mise shim works whatever PATH
# Claude Code was started with. --isolated gives each Claude session its own
# temporary Chrome profile, so several agents can use it at once (a shared profile
# only allows one browser).
mcp_args="--isolated"
if [ "$(claude mcp get chrome-devtools 2>/dev/null | sed -n 's/^ *Args: *//p')" != "${mcp_args}" ]; then
    if claude mcp get chrome-devtools >/dev/null 2>&1; then
        claude mcp remove --scope user chrome-devtools >/dev/null
    fi
    claude mcp add --scope user chrome-devtools -- \
        "${HOME}/.local/share/mise/shims/chrome-devtools-mcp" ${mcp_args}
fi

# Claude Desktop (packages/claude-desktop), when installed: its config file also
# holds the app's own state (per-account preferences), so it isn't versioned; only
# the mcpServers.chrome-devtools key is set, with jq, and only when it differs.
desktop_config="${HOME}/Library/Application Support/Claude/claude_desktop_config.json"
desktop_server="$(jq -n --arg cmd "${HOME}/.local/share/mise/shims/chrome-devtools-mcp" \
    --arg args "${mcp_args}" '{command: $cmd, args: ($args | split(" "))}')"
if [ -d /Applications/Claude.app ]; then
    mkdir -p "$(dirname "${desktop_config}")"
    [ -f "${desktop_config}" ] || echo '{}' > "${desktop_config}"
    if ! jq -e --argjson s "${desktop_server}" '.mcpServers["chrome-devtools"] == $s' \
        "${desktop_config}" >/dev/null; then
        tmp="$(mktemp "${desktop_config}.XXXXXX")"
        jq --argjson s "${desktop_server}" '.mcpServers["chrome-devtools"] = $s' \
            "${desktop_config}" > "${tmp}"
        mv "${tmp}" "${desktop_config}"
        _dot_warn "Registered chrome-devtools in Claude Desktop: restart it to load the server"
    fi
fi

_dot_ok "chrome-devtools-mcp installed"
