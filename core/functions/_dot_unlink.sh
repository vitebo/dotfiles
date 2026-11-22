#!/usr/bin/env bash
# Undoes `_dot_link`: removes `target` when it's a symlink to `source`, moves
# `<target>.bak` back, then removes the parent dirs left empty. Stops at `$HOME`,
# `~/.config` and direct children of `$HOME` (eg `~/Pictures`, `~/.claude`).
#
#   _dot_unlink "${DOT_PACKAGE_DIR}/config/vimrc" "${HOME}/.vimrc"

_dot_unlink() {
    local source="$1"
    local target="$2"

    if [ -L "${target}" ]; then
        if [ "$(readlink "${target}")" = "${source}" ]; then
            rm "${target}"
        else
            _dot_warn "Kept ${target}: links to $(readlink "${target}"), not ${source}"
            return 0
        fi
    elif [ -e "${target}" ]; then
        _dot_warn "Kept ${target}: not a symlink"
        return 0
    fi

    if [ -e "${target}.bak" ] && [ ! -e "${target}" ]; then
        mv "${target}.bak" "${target}"
        _dot_warn "Restored ${target} from ${target}.bak"
    fi

    local dir
    dir="$(dirname "${target}")"
    while [ "${dir}" != "${HOME}" ] && [ "${dir}" != "${HOME}/.config" ] \
        && [ "$(dirname "${dir}")" != "${HOME}" ] && [ -d "${dir}" ] \
        && [ -z "$(ls -A "${dir}")" ]; do
        rmdir "${dir}"
        dir="$(dirname "${dir}")"
    done
}
