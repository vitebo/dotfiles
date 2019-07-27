# ASDF config: https://asdf-vm.com/#/core-manage-asdf-vm
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# a command-line fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# open tmux
if [[ ! $TERM =~ screen ]]; then
  exec tmux
fi
