#!/usr/bin/env bash
# Runs as root: directly when already root (common in containers), otherwise via sudo.
#
#   _dot_sudo chsh -s /usr/bin/zsh "$(id -un)"

_dot_sudo() {
    if [ "$(id -u)" -eq 0 ]; then
        "$@"
    elif command -v sudo >/dev/null 2>&1; then
        sudo "$@"
    else
        _dot_err "Root required to run: $*"
        return 1
    fi
}
