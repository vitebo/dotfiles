#!/usr/bin/env bash
# Exports `DOT_PM` (apt|brew). Keeps an already defined value.
# Returns 1 when no supported package manager is found.
#
#   _dot_select_package_manager

_dot_select_package_manager() {
    if [ -n "${DOT_PM:-}" ]; then
        return 0
    fi

    # brew may be installed but not in PATH yet (eg right after 01-mac-homebrew).
    if ! command -v brew >/dev/null 2>&1; then
        local brew_bin
        for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
            if [ -x "${brew_bin}" ]; then
                eval "$("${brew_bin}" shellenv)"
                break
            fi
        done
    fi

    if command -v apt-get >/dev/null 2>&1; then
        DOT_PM="apt"
    elif command -v brew >/dev/null 2>&1; then
        DOT_PM="brew"
    else
        return 1
    fi
    export DOT_PM
}
