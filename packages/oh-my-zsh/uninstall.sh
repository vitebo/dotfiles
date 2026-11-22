#!/usr/bin/env bash
# oh-my-zsh: zsh framework (themes, plugins, completion, history...).
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/../.." && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_title "oh-my-zsh (uninstall)"

_dot_unlink_zsh "${DOT_PACKAGE_DIR}/config/22-oh-my-zsh.zsh"
rm -rf "${XDG_DATA_HOME:-${HOME}/.local/share}/oh-my-zsh"

_dot_ok "oh-my-zsh uninstalled"
