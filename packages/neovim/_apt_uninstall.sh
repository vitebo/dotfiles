#!/usr/bin/env bash
# The GitHub release installed by _apt.sh.
if [ "$(readlink /usr/local/bin/nvim 2>/dev/null)" = "/opt/nvim/bin/nvim" ]; then
    _dot_sudo rm /usr/local/bin/nvim
fi
if [ -d /opt/nvim ]; then
    _dot_sudo rm -rf /opt/nvim
fi
