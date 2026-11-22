#!/usr/bin/env bash
# Exports `DOT_OS` (mac|linux). Keeps an already defined value.
#
#   _dot_detect_os

_dot_detect_os() {
    if [ -n "${DOT_OS:-}" ]; then
        return 0
    fi

    case "$(uname -s)" in
        Darwin) DOT_OS="mac" ;;
        Linux)  DOT_OS="linux" ;;
        *)
            _dot_err "Unsupported OS: $(uname -s)"
            return 1
            ;;
    esac
    export DOT_OS
}
