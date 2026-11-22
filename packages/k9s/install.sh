#!/usr/bin/env bash
# k9s: terminal UI for Kubernetes clusters.
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "k9s"
_dot_select_package_manager || true
_dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

# File by file: ~/.config/k9s also holds per-cluster state (clusters/), skins...
_dot_link "${DOT_PACKAGE_DIR}/config/config.yaml" "${HOME}/.config/k9s/config.yaml"
for skin in catppuccin-latte catppuccin-mocha; do
    _dot_link "${DOT_PACKAGE_DIR}/config/skins/${skin}.yaml" "${HOME}/.config/k9s/skins/${skin}.yaml"
done
_dot_link_zsh "${DOT_PACKAGE_DIR}/config/43-k9s.zsh"

_dot_ok "k9s installed"
