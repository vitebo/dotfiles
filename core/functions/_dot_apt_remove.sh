#!/usr/bin/env bash
# Purges the given apt packages that are installed, then the dependencies nothing
# needs anymore. Without prompts.
#
#   _dot_apt_remove zsh

_dot_apt_remove() {
    local installed=""
    local package
    for package in "$@"; do
        if dpkg -s "${package}" >/dev/null 2>&1; then
            installed="${installed} ${package}"
        fi
    done

    if [ -n "${installed}" ]; then
        # shellcheck disable=SC2086
        _dot_sudo env DEBIAN_FRONTEND=noninteractive apt-get purge -qqy ${installed}
    fi
    _dot_sudo env DEBIAN_FRONTEND=noninteractive apt-get autoremove -qqy
}
