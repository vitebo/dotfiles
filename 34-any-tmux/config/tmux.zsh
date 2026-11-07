# tz <query>: tmux session in the directory zoxide (33-any-zoxide) finds for the
# query, named after it; attaches to it if it already exists (switches to it when
# already in tmux).

(( $+commands[tmux] && $+commands[zoxide] )) || return 0

tz() {
    local dir name
    dir="$(zoxide query -- "$@")" || return 1
    # tmux session names can't contain "." or ":"
    name="${${dir:t}//[.:]/_}"

    # `command`: skip oh-my-zsh's tmux alias, expanded when this function is defined
    if ! command tmux has-session -t "=${name}" 2>/dev/null; then
        command tmux new-session -d -s "${name}" -c "${dir}"
    fi

    if [[ -n "${TMUX}" ]]; then
        command tmux switch-client -t "=${name}"
    else
        command tmux attach-session -t "=${name}"
    fi
}
