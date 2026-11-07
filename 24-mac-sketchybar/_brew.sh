#!/usr/bin/env bash
# Not in the official formulae: installed from the author's tap.
brew tap -q FelixKratz/formulae
brew trust --formula felixkratz/formulae/sketchybar
HOMEBREW_NO_ENV_HINTS=1 brew install -q sketchybar
