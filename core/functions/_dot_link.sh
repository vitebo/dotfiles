#!/usr/bin/env bash
# Symlinks `target` -> `source`. An existing regular file is moved to `<target>.bak`.
#
#   _dot_link "${DOT_PACKAGE_DIR}/config/vimrc" "${HOME}/.vimrc"

_dot_link() {
    local source="$1"
    local target="$2"

    mkdir -p "$(dirname "${target}")"
    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        mv "${target}" "${target}.bak"
        _dot_warn "Existing ${target} moved to ${target}.bak"
    fi
    ln -nsf "${source}" "${target}"
}
