#!/usr/bin/env bash
# Git clean filter for config/settings.json (see the root .gitattributes; install.sh
# sets it up). Drops the keys Claude Code saves per machine (/model, /effort) and
# sorts the top-level keys, so neither those changes nor Claude Code's key
# reordering reach git.
set -euo pipefail

jq 'del(.model, .effortLevel, .modelSettings) | to_entries | sort_by(.key) | from_entries'
