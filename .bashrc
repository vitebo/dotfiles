# path to your oh-my-bash installation.
export OSH=$HOME/.oh-my-bash

# set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="font"

# enable command auto-correction.
ENABLE_CORRECTION="true"

# the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

completions=(
  git
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)

source $OSH/oh-my-bash.sh

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
