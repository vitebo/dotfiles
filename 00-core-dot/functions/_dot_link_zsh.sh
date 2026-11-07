#!/usr/bin/env bash
# Symlinks a package's zsh snippet into `~/.config/zsh/`, prefixed with the
# package's `NN` so `~/.zshrc` loads snippets in package order.
#
#   _dot_link_zsh "${DOT_PACKAGE_DIR}/config/neovim.zsh"   # -> ~/.config/zsh/17-neovim.zsh

_dot_link_zsh() {
    local source="$1"
    local package_name
    package_name="$(basename "$(dirname "$(dirname "${source}")")")"

    _dot_link "${source}" "${HOME}/.config/zsh/${package_name%%-*}-$(basename "${source}")"
}
