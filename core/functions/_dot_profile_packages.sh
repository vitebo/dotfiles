#!/usr/bin/env bash
# Prints the packages of a profile (`profiles/<name>`), one per line, in install
# order. A profile lists one package per line; `include <profile>` expands another
# profile in place; `#` starts a comment. A package already listed is skipped.
# Fails on an unknown profile or package, or an include loop.
#
#   _dot_profile_packages work

_dot_profile_packages() {
    _dot_profile_seen=" "
    _dot_profile_expand "$1" " "
}

_dot_profile_expand() {
    local profile="$1"
    local stack="$2"
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
            _dot_profile_expand "${arg}" "${stack}${profile} " || return 1
            continue
        fi

        if [ ! -f "${root}/packages/${word}/install.sh" ]; then
            _dot_err "Unknown package in profiles/${profile}: ${word}"
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
