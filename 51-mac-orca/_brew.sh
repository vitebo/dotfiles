#!/usr/bin/env bash
# Not in the official casks (bare `orca` is an unrelated Plotly cask): installed
# from the author's tap.
brew tap -q stablyai/orca
brew trust --cask stablyai/orca/orca
HOMEBREW_NO_ENV_HINTS=1 brew install -q --cask stablyai/orca/orca
