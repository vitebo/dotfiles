#!/usr/bin/env bash
# Runs the package's `_<pm>_uninstall.sh`, if any. No script = nothing to remove.
#
#   _dot_uninstall_with_package_manager "${DOT_PACKAGE_DIR}"

_dot_uninstall_with_package_manager() {
    local package_dir="$1"

    if [ -z "${DOT_PM:-}" ]; then
        return 0
    fi

    local script="${package_dir}/_${DOT_PM}_uninstall.sh"
    if [ -f "${script}" ]; then
        ( source "${script}" )
    fi
}
