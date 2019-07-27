#!/usr/bin/env bash

if [[ ! $TERM =~ screen ]]; then
  exec tmux
fi
