#!/usr/bin/env bash
# Runs the package's `_<pm>.sh`, if any. No script = nothing to install.
#
#   _dot_install_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_install_with_package_manager() {
    local package_dir="$1"

    if [ -z "${DOT_PM:-}" ]; then
        _dot_err "No supported package manager found (apt, brew)"
        return 1
    fi

    local script="${package_dir}/_${DOT_PM}.sh"
    if [ -f "${script}" ]; then
        ( source "${script}" )
    fi
}
