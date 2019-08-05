#!/usr/bin/env bash

if [[ ! $TERM =~ screen && ! $TMUX ]]; then
  exec tmux
fi
