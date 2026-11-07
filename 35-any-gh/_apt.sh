#!/usr/bin/env bash
# Distros ship old gh versions: installed from GitHub's official apt repository.

if [ ! -f /etc/apt/sources.list.d/github-cli.list ]; then
    _dot_require curl
    _dot_sudo mkdir -p -m 755 /etc/apt/keyrings
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        | _dot_sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
    _dot_sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
        | _dot_sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    _dot_sudo env DEBIAN_FRONTEND=noninteractive apt-get -qq update
fi

_dot_apt_install gh
