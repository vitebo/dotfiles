#!/usr/bin/env bash
# Fails when any of the given commands is missing, ie a prerequisite package
# wasn't installed first.
#
#   _dot_require nvim rg tree-sitter

_dot_require() {
    local missing=""
    local cmd
    for cmd in "$@"; do
        if ! command -v "${cmd}" >/dev/null 2>&1; then
            missing="${missing} ${cmd}"
        fi
    done

    if [ -n "${missing}" ]; then
        _dot_err "Missing prerequisites:${missing} (install their packages first)"
        return 1
    fi
}
