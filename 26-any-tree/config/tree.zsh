# Listing aliases with tree instead of ls, like gnugat. Loaded after oh-my-zsh
# (higher NN), so they replace its l / la / ll aliases.

alias l="tree -L 1"
alias la="tree -a -L 1"
alias ll="tree -hDpug -L 1"
alias lla="tree -ahDpug -L 1"
