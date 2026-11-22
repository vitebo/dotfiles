#!/usr/bin/env bash
# Symlinks a package's zsh snippet into `~/.config/zsh/`. Snippets are named
# `<NN>-<name>.zsh`: `~/.zshrc` loads them sorted, so `NN` is the shell load order,
# the same on every device whatever the profile's install order.
#
#   _dot_link_zsh "${DOT_PACKAGE_DIR}/config/17-neovim.zsh"   # -> ~/.config/zsh/17-neovim.zsh

_dot_link_zsh() {
    local source="$1"

    _dot_link "${source}" "${HOME}/.config/zsh/$(basename "${source}")"
}
