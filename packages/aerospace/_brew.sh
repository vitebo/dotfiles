#!/usr/bin/env bash
# Not in the official casks: installed from the author's tap.
brew tap -q nikitabobko/tap
brew trust --cask nikitabobko/tap/aerospace
HOMEBREW_NO_ENV_HINTS=1 brew install -q --cask nikitabobko/tap/aerospace
