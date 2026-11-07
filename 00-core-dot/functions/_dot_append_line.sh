#!/usr/bin/env bash
# Appends `line` to `file`, only if the line isn't there yet.
#
#   _dot_append_line "${HOME}/.zprofile" 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"'

_dot_append_line() {
    local file="$1"
    local line="$2"

    mkdir -p "$(dirname "${file}")"
    touch "${file}"
    if ! grep -qxF -- "${line}" "${file}"; then
        printf '%s\n' "${line}" >> "${file}"
    fi
}
