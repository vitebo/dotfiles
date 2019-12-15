# ASDF config: https://asdf-vm.com/#/core-manage-asdf-vm
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# fuzzy-finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# path
export PATH="$(yarn global bin):$PATH"
export PATH="~/bin/:$PATH"
