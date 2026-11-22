#!/usr/bin/env bash
# k9s: terminal UI for Kubernetes clusters.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "k9s (uninstall)"

_dot_unlink_zsh "${DOT_PACKAGE_DIR}/config/43-k9s.zsh"
for skin in catppuccin-latte catppuccin-mocha; do
    _dot_unlink "${DOT_PACKAGE_DIR}/config/skins/${skin}.yaml" "${HOME}/.config/k9s/skins/${skin}.yaml"
done
_dot_unlink "${DOT_PACKAGE_DIR}/config/config.yaml" "${HOME}/.config/k9s/config.yaml"

_dot_select_package_manager || true
_dot_uninstall_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_ok "k9s uninstalled"
