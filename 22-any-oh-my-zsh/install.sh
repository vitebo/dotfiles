#!/usr/bin/env bash
# oh-my-zsh: zsh framework (themes, plugins, completion, history...).
set -euo pipefail

DOT_PACKAGE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOT_ROOT="$(cd "${DOT_PACKAGE_DIR}/.." && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_title "oh-my-zsh"
_dot_require git zsh

# Cloned directly: the official installer would replace ~/.zshrc.
omz_dir="${XDG_DATA_HOME:-${HOME}/.local/share}/oh-my-zsh"
if [ ! -d "${omz_dir}" ]; then
    git clone --quiet --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "${omz_dir}"
fi

_dot_link_zsh "${DOT_PACKAGE_DIR}/config/oh-my-zsh.zsh"

_dot_ok "oh-my-zsh installed"
