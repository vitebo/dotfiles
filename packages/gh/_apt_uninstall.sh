#!/usr/bin/env bash
_dot_apt_remove gh
# GitHub's apt repository, added by _apt.sh.
if [ -f /etc/apt/sources.list.d/github-cli.list ]; then
    _dot_sudo rm -f /etc/apt/sources.list.d/github-cli.list \
        /etc/apt/keyrings/githubcli-archive-keyring.gpg
    _dot_sudo env DEBIAN_FRONTEND=noninteractive apt-get -qq update
fi
