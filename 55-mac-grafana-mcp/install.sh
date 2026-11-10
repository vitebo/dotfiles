#!/usr/bin/env bash
# Grafana MCP: lets Claude Code query Grafana (dashboards, logs, metrics).
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "grafana-mcp"
_dot_require mise

_dot_link "${DOT_PACKAGE_DIR}/config/mise.toml" "${HOME}/.config/mise/conf.d/grafana-mcp.toml"

# Installs the server declared above; already installed versions are skipped.
# It isn't registered in Claude Code here: each Grafana instance needs its own URL
# and token, so servers are added by hand on each machine (see README).
mise install --yes

_dot_ok "grafana-mcp installed"
