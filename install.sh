#!/usr/bin/env bash
# Installs every `<NN>-<scope>-<name>/` package whose scope is in `DOT_SCOPES`.
#
#   bash install.sh                  # default scopes: "any <os>"
#   DOT_SCOPES="any" bash install.sh # cross-platform packages only
set -euo pipefail

DOT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${DOT_ROOT}/00-core-dot/lib.sh"

_dot_detect_os
export DOT_SCOPES="${DOT_SCOPES:-any ${DOT_OS}}"

_dot_title "dotfiles · os: ${DOT_OS} · scopes: ${DOT_SCOPES}"

if _dot_select_package_manager && [ "${DOT_PM}" = "apt" ]; then
    _dot_sudo env DEBIAN_FRONTEND=noninteractive apt-get -qq update
fi

for package_dir in "${DOT_ROOT}"/[0-9][0-9]-*/; do
    IFS=- read -r _order scope _name <<< "$(basename "${package_dir}")"

    case " ${DOT_SCOPES} " in
        *" ${scope} "*) ;;
        *) continue ;;
    esac

    if [ -f "${package_dir}install.sh" ]; then
        bash "${package_dir}install.sh"
    fi
done

_dot_title "done! open a new terminal or run: exec zsh"
