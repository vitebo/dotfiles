#!/usr/bin/env bash
# Installs packages with apt-get, without prompts.
#
#   _dot_apt_install zsh

_dot_apt_install() {
    _dot_sudo env DEBIAN_FRONTEND=noninteractive apt-get install -qqy "$@"
}
