#!/usr/bin/env bash
# The GitHub release binary installed by _apt.sh.
if [ -f /usr/local/bin/tree-sitter ]; then
    _dot_sudo rm /usr/local/bin/tree-sitter
fi
