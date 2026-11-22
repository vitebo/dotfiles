# oh-my-zsh config: the framework is cloned by install.sh, its settings live here.
# Options: https://github.com/ohmyzsh/ohmyzsh/wiki/Settings

export ZSH="${XDG_DATA_HOME:-${HOME}/.local/share}/oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git)
# Tool plugins, each named like its command and enabled only when that command
# exists (checked at shell startup), since plugins may error out without it:
#   fzf      key bindings and ** completion (packages/fzf)
#   zoxide   z / zi (packages/zoxide)
#   tmux     aliases (packages/tmux)
#   docker   aliases (packages/docker)
#   aws      completion and profile helpers (packages/aws-cli)
#   mise     activation and completion (packages/mise)
#   kubectl  aliases and completion (packages/kubectl)
#   helm     aliases and completion (packages/helm)
for _dot_plugin in fzf zoxide tmux docker aws mise kubectl helm; do
    if (( $+commands[${_dot_plugin}] )); then
        plugins+=("${_dot_plugin}")
    fi
done
unset _dot_plugin

if [[ -f "${ZSH}/oh-my-zsh.sh" ]]; then
    source "${ZSH}/oh-my-zsh.sh"
fi
