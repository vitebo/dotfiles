# k9s with the Catppuccin skin matching the terminal's light / dark mode
# (CLAUDE.md "Themes"). k9s turns skin colors into fixed RGB, so it can't follow
# the terminal's palette: the skin is picked when k9s starts, through K9S_SKIN,
# from the terminal's answer to DSR 996 (Ghostty and tmux answer it). A running
# k9s keeps its skin until it's restarted.

(( $+commands[k9s] )) || return 0

# Prints "light" or "dark": the terminal's answer to DSR 996 (`CSI ? 997 ; 2 n`
# is light), or dark when it doesn't answer within 0.2s. Talks to /dev/tty, since
# its output is captured by the caller.
_dot_k9s_mode() {
    local reply="" c saved
    if ! { : < /dev/tty > /dev/tty } 2> /dev/null; then
        print dark
        return
    fi
    saved="$(stty -g < /dev/tty)"
    stty raw -echo < /dev/tty
    printf '\e[?996n' > /dev/tty
    while read -r -t 0.2 -k 1 c < /dev/tty; do
        reply+="${c}"
        [[ "${c}" == n ]] && break
    done
    stty "${saved}" < /dev/tty
    if [[ "${reply}" == *'997;2n' ]]; then
        print light
    else
        print dark
    fi
}

k9s() {
    local skin="catppuccin-mocha"
    [[ "$(_dot_k9s_mode)" == light ]] && skin="catppuccin-latte"
    K9S_SKIN="${K9S_SKIN:-${skin}}" command k9s "$@"
}
