#!/usr/bin/env bash
# Reads a profile (`profiles/<name>`). A profile lists one package per line;
# `include <profile>` expands another profile in place; `set DOT_<NAME>=<value>`
# sets a value for the packages' installers (no spaces; a later `set` wins, so a
# device overrides what it includes); `#` starts a comment.
# Fails on an unknown profile or package, a package without uninstall.sh, a bad
# `set` or an include loop.
#
#   _dot_profile_packages work   # packages in install order, one per line (duplicates skipped)
#   _dot_profile_env imac        # `DOT_<NAME>=<value>` lines, in profile order
#   _dot_profile_export imac     # exports them
#   _dot_profile_save imac       # remembers this device's profile (install.sh)
#   _dot_profile_export_saved    # exports the saved profile's values, if any

DOT_PROFILE_FILE="${HOME}/.local/state/dotfiles/profile"

_dot_profile_packages() {
    _dot_profile_seen=" "
    _dot_profile_expand packages "$1" " "
}

_dot_profile_env() {
    _dot_profile_expand env "$1" " "
}

_dot_profile_export() {
    local env assignment
    env="$(_dot_profile_env "$1")" || return 1
    for assignment in ${env}; do
        export "${assignment}"
    done
}

_dot_profile_save() {
    mkdir -p "$(dirname "${DOT_PROFILE_FILE}")"
    echo "$1" > "${DOT_PROFILE_FILE}"
}

_dot_profile_export_saved() {
    if [ -f "${DOT_PROFILE_FILE}" ]; then
        _dot_profile_export "$(cat "${DOT_PROFILE_FILE}")"
    fi
}

_dot_profile_expand() {
    local mode="$1"
    local profile="$2"
    local stack="$3"
    local root file line word arg
    root="$(cd "${DOT_LIB_DIR}/.." && pwd)"
    file="${root}/profiles/${profile}"

    if [ ! -f "${file}" ]; then
        _dot_err "Unknown profile: ${profile}"
        return 1
    fi
    case "${stack}" in
        *" ${profile} "*)
            _dot_err "Include loop:${stack}${profile}"
            return 1
            ;;
    esac

    while IFS= read -r line || [ -n "${line}" ]; do
        read -r word arg _ <<< "${line%%#*}"
        if [ -z "${word:-}" ]; then
            continue
        fi

        if [ "${word}" = "include" ]; then
            _dot_profile_expand "${mode}" "${arg}" "${stack}${profile} " || return 1
            continue
        fi

        if [ "${word}" = "set" ]; then
            if [[ ! "${arg:-}" =~ ^DOT_[A-Z0-9_]+=[^[:space:]]*$ ]]; then
                _dot_err "Bad set in profiles/${profile}: ${line}"
                return 1
            fi
            if [ "${mode}" = "env" ]; then
                echo "${arg}"
            fi
            continue
        fi

        if [ "${mode}" != "packages" ]; then
            continue
        fi
        if [ ! -f "${root}/packages/${word}/install.sh" ]; then
            _dot_err "Unknown package in profiles/${profile}: ${word}"
            return 1
        fi
        if [ ! -f "${root}/packages/${word}/uninstall.sh" ]; then
            _dot_err "Package without uninstall.sh: ${word}"
            return 1
        fi
        case "${_dot_profile_seen}" in
            *" ${word} "*) ;;
            *)
                _dot_profile_seen="${_dot_profile_seen}${word} "
                echo "${word}"
                ;;
        esac
    done < "${file}"
}
