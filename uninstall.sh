#!/usr/bin/env bash
# Uninstalls the packages of a device profile (`profiles/<name>`), in reverse
# order: dependents before their prerequisites.
#
#   bash uninstall.sh work     # a mac: the profile is required
#   bash uninstall.sh          # linux: defaults to the devcontainer profile
set -euo pipefail

DOT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${DOT_ROOT}/core/lib.sh"

_dot_detect_os

profile="${1:-}"
if [ -z "${profile}" ]; then
    if [ "${DOT_OS}" = "linux" ]; then
        profile="devcontainer"
    else
        _dot_err "Usage: bash uninstall.sh <profile>"
        echo "Profiles: $(cd "${DOT_ROOT}/profiles" && echo *)" >&2
        exit 1
    fi
fi

install_order="$(_dot_profile_packages "${profile}")"
packages=""
for package in ${install_order}; do
    packages="${package} ${packages}"
done

_dot_title "dotfiles uninstall · os: ${DOT_OS} · profile: ${profile}"

for package in ${packages}; do
    bash "${DOT_ROOT}/packages/${package}/uninstall.sh"
done

# The profile saved by install.sh.
rm -f "${DOT_PROFILE_FILE}"
rmdir "$(dirname "${DOT_PROFILE_FILE}")" 2>/dev/null || true

_dot_title "done! open a new terminal"
