# if not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# PS1
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# ASDF config: https://asdf-vm.com/#/core-manage-asdf-vm
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash


# PATH
export PATH="$(yarn global bin):$PATH"

# alias definitions.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# include .private if it exists
if [ -f "$HOME/.private.sh" ]; then
  source "$HOME/.private.sh"
fi

# open tmux
if [[ ! $TERM =~ screen ]]; then
  exec tmux
fi
