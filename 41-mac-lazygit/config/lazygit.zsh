# lazygit: `lg` alias, and delta (29-any-git-delta) diffs when it's installed,
# by merging delta.yml on top of config.yml.

(( $+commands[lazygit] )) || return 0

alias lg="lazygit"

if (( $+commands[delta] )); then
    export LG_CONFIG_FILE="${XDG_CONFIG_HOME:-${HOME}/.config}/lazygit/config.yml,${XDG_CONFIG_HOME:-${HOME}/.config}/lazygit/delta.yml"
fi
