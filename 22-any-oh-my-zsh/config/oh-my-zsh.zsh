# oh-my-zsh config: the framework is cloned by install.sh, its settings live here.
# Options: https://github.com/ohmyzsh/ohmyzsh/wiki/Settings

export ZSH="${XDG_DATA_HOME:-${HOME}/.local/share}/oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git)
# fzf key bindings and ** completion (32-any-fzf), only when fzf is installed:
# the plugin errors out otherwise.
if (( $+commands[fzf] )); then
    plugins+=(fzf)
fi
# zoxide's z / zi (33-any-zoxide), only when zoxide is installed: same reason.
if (( $+commands[zoxide] )); then
    plugins+=(zoxide)
fi
# tmux aliases (34-any-tmux), only when tmux is installed: same reason.
if (( $+commands[tmux] )); then
    plugins+=(tmux)
fi
# docker aliases (37-mac-docker), only when docker is installed: same reason.
if (( $+commands[docker] )); then
    plugins+=(docker)
fi

if [[ -f "${ZSH}/oh-my-zsh.sh" ]]; then
    source "${ZSH}/oh-my-zsh.sh"
fi
