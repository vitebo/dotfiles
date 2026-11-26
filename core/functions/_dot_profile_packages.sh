#!/usr/bin/env bash
# Reads a device profile (`profiles/<name>`). Each line is `<keyword> <argument>`:
# `package <name>` installs a package (in line order); `preset <name>` expands a
# shared list (`presets/<name>`, same format, may use other presets) in place;
# `set DOT_<NAME>=<value>` sets a value for the packages' installers (no spaces; a
# later `set` wins, so a device overrides its presets); `#` starts a comment.
# Fails on an unknown profile, preset, package or keyword, a package without
# uninstall.sh, a bad `set` or a preset loop.
#
#   _dot_profile_packages work   # packages in install order, one per line (duplicates skipped)
#   _dot_profile_env studio      # `DOT_<NAME>=<value>` lines, in profile order
#   _dot_profile_export studio   # exports them
#   _dot_profile_save studio     # remembers this device's profile (install.sh)
#   _dot_profile_export_saved    # exports the saved profile's values, if any

DOT_PROFILE_FILE="${HOME}/.local/state/dotfiles/profile"

_dot_profile_packages() {
    _dot_profile_seen=" "
    _dot_profile_expand packages profiles "$1" " "
}

_dot_profile_env() {
    _dot_profile_expand env profiles "$1" " "
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
    local kind="$2"
    local name="$3"
    local stack="$4"
    local root file line word arg
    root="$(cd "${DOT_LIB_DIR}/.." && pwd)"
    file="${root}/${kind}/${name}"

    if [ ! -f "${file}" ]; then
        _dot_err "Unknown ${kind%s}: ${name}"
        return 1
    fi
    case "${stack}" in
        *" ${name} "*)
            _dot_err "Preset loop:${stack}${name}"
            return 1
            ;;
    esac

    while IFS= read -r line || [ -n "${line}" ]; do
        read -r word arg _ <<< "${line%%#*}"
        if [ -z "${word:-}" ]; then
            continue
        fi

        case "${word}" in
            preset)
                _dot_profile_expand "${mode}" presets "${arg:-}" "${stack}${name} " || return 1
                ;;
            set)
                if [[ ! "${arg:-}" =~ ^DOT_[A-Z0-9_]+=[^[:space:]]*$ ]]; then
                    _dot_err "Bad set in ${kind}/${name}: ${line}"
                    return 1
                fi
                if [ "${mode}" = "env" ]; then
                    echo "${arg}"
                fi
                ;;
            package)
                if [ ! -f "${root}/packages/${arg:-}/install.sh" ]; then
                    _dot_err "Unknown package in ${kind}/${name}: ${arg:-}"
                    return 1
                fi
                if [ ! -f "${root}/packages/${arg}/uninstall.sh" ]; then
                    _dot_err "Package without uninstall.sh: ${arg}"
                    return 1
                fi
                if [ "${mode}" != "packages" ]; then
                    continue
                fi
                case "${_dot_profile_seen}" in
                    *" ${arg} "*) ;;
                    *)
                        _dot_profile_seen="${_dot_profile_seen}${arg} "
                        echo "${arg}"
                        ;;
                esac
                ;;
            *)
                _dot_err "Unknown keyword in ${kind}/${name}: ${word}"
                return 1
                ;;
        esac
    done < "${file}"
}
