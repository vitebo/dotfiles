#!/usr/bin/env bash
# Grafana MCP: lets Claude Code query Grafana (dashboards, logs, metrics).
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "grafana-mcp (uninstall)"

# Servers registered by hand in Claude Code are removed by hand too (see README).
if command -v mise >/dev/null; then
    mise uninstall --all github:grafana/mcp-grafana
fi
_dot_unlink "${DOT_PACKAGE_DIR}/config/mise.toml" "${HOME}/.config/mise/conf.d/grafana-mcp.toml"

_dot_ok "grafana-mcp uninstalled"
