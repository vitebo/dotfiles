#!/usr/bin/env bash
# cloudflared: Cloudflare Tunnel client.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "cloudflared (uninstall)"
_dot_select_package_manager || true
_dot_uninstall_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "cloudflared uninstalled"
