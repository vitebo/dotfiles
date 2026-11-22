#!/usr/bin/env bash
# Untaps a brew tap when it's tapped and nothing installed comes from it anymore
# (a tap may be shared, eg FelixKratz/formulae by sketchybar and borders).
#
#   _dot_brew_untap FelixKratz/formulae

_dot_brew_untap() {
    local tap="$1"
    local tap_lower
    tap_lower="$(echo "${tap}" | tr '[:upper:]' '[:lower:]')"

    if ! brew tap | grep -qix "${tap}"; then
        return 0
    fi
    if brew list --full-name | tr '[:upper:]' '[:lower:]' | grep -q "^${tap_lower}/"; then
        return 0
    fi
    brew untap -q "${tap}"
}
