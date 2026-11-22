#!/usr/bin/env bash
# Undoes `_dot_link_zsh`: removes the snippet's link from `~/.config/zsh/`.
#
#   _dot_unlink_zsh "${DOT_PACKAGE_DIR}/config/17-neovim.zsh"

_dot_unlink_zsh() {
    local source="$1"

    _dot_unlink "${source}" "${HOME}/.config/zsh/$(basename "${source}")"
}
