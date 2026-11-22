#!/usr/bin/env bash
# Uninstalls the given brew formulae (or casks with `--cask`) that are installed,
# then the dependencies nothing needs anymore.
#
#   _dot_brew_uninstall ripgrep
#   _dot_brew_uninstall --cask ghostty

_dot_brew_uninstall() {
    local kind="--formula"
    if [ "$1" = "--cask" ]; then
        kind="--cask"
        shift
    fi

    local name
    for name in "$@"; do
        if brew list "${kind}" "${name}" >/dev/null 2>&1; then
            HOMEBREW_NO_ENV_HINTS=1 brew uninstall -q "${kind}" "${name}"
        fi
    done
    HOMEBREW_NO_ENV_HINTS=1 brew autoremove -q
}
