# zoxide integrations with other packages. `z` / `zi` come from oh-my-zsh's zoxide
# plugin (22-any-oh-my-zsh); `zi` uses fzf (32-any-fzf) when installed.
#
# eza (31-any-eza) tree preview in `zi`, like fzf's alt-c. _ZO_FZF_OPTS replaces
# all of zoxide's fzf options, so these are zoxide 0.10's defaults with only the
# preview changed (from `ls`).

(( $+commands[zoxide] )) || return 0

if (( $+commands[fzf] )) && (( $+commands[eza] )); then
    export _ZO_FZF_OPTS="--exact --no-sort --bind=ctrl-z:ignore,btab:up,tab:down \
--cycle --keep-right --border=sharp --height=45% --info=inline --layout=reverse \
--tabstop=1 --exit-0 \
--preview='eza --tree --color=always {2..} | head -n 200' \
--preview-window=down,30%,sharp"
fi
