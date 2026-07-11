#!/usr/bin/env bash
#
# common.sh — shared utilities: logging, colored messages, small helpers.
#
# This module only defines functions. It runs no code when loaded.

# --- Logging -------------------------------------------------------------
# Colors are used only when stderr is a terminal and NO_COLOR is unset.
_supports_color() {
    [ -t 2 ] && [ -z "${NO_COLOR:-}" ]
}

_log() {
    local color="$1" symbol="$2"
    shift 2
    if _supports_color; then
        printf '\033[%sm%s\033[0m %s\n' "$color" "$symbol" "$*" >&2
    else
        printf '%s %s\n' "$symbol" "$*" >&2
    fi
}

log_info()    { _log '34' '•' "$@"; }   # blue
log_success() { _log '32' '✓' "$@"; }   # green
log_warn()    { _log '33' '!' "$@"; }   # yellow
log_error()   { _log '31' '✗' "$@"; }   # red
log_step()    { _log '35' '»' "$@"; }   # magenta

# --- Helpers -------------------------------------------------------------
_command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Run a command as root when possible.
_sudo() {
    if [ "$(id -u)" -eq 0 ]; then
        "$@"
    elif _command_exists sudo; then
        sudo "$@"
    else
        log_error "Root privileges required but sudo is unavailable"
        return 1
    fi
}

# Ask the user for confirmation. Defaults to "no" in non-interactive shells.
_confirm() {
    local prompt="${1:-Continue?}"
    if [ ! -t 0 ]; then
        return 1
    fi
    local reply
    printf '%s [y/N] ' "$prompt" >&2
    read -r reply
    [[ "$reply" =~ ^[Yy]$ ]]
}
