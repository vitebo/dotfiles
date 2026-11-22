#!/usr/bin/env bash
# Installs the packages of a device profile (`profiles/<name>`), in its order.
#
#   bash install.sh work     # a mac: the profile is required
#   bash install.sh          # linux: defaults to the devcontainer profile
set -euo pipefail

DOT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_detect_os

profile="${1:-}"
if [ -z "${profile}" ]; then
    if [ "${DOT_OS}" = "linux" ]; then
        profile="devcontainer"
    else
        _dot_err "Usage: bash install.sh <profile>"
        echo "Profiles: $(cd "${DOT_ROOT}/profiles" && echo *)" >&2
        exit 1
    fi
fi

packages="$(_dot_profile_packages "${profile}")"

_dot_title "dotfiles · os: ${DOT_OS} · profile: ${profile}"

if _dot_select_package_manager && [ "${DOT_PM}" = "apt" ]; then
    _dot_sudo env DEBIAN_FRONTEND=noninteractive apt-get -qq update
fi

for package in ${packages}; do
    bash "${DOT_ROOT}/packages/${package}/install.sh"
done

_dot_title "done! open a new terminal or run: exec zsh"
