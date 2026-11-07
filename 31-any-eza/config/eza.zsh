# Listing aliases with eza, one level as a tree. Loaded after
# oh-my-zsh (higher NN), so they replace its l / la / ll aliases.
# Colors and icons stay `auto` (only on a terminal), so piping
# (eg `ll | grep`) gets plain text.

if (( $+commands[eza] )); then
    alias l="eza --tree --level=1 --icons=auto"
    alias la="eza --tree --level=1 --icons=auto --all"
    alias ll="eza --tree --level=1 --icons=auto --long --group --git"
    alias lla="eza --tree --level=1 --icons=auto --all --long --group --git"
fi
