# oh-my-zsh config: the framework is cloned by install.sh, its settings live here.
# Options: https://github.com/ohmyzsh/ohmyzsh/wiki/Settings

export ZSH="${XDG_DATA_HOME:-${HOME}/.local/share}/oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git)
# Tool plugins, each named like its command and enabled only when that command
# exists (checked at shell startup), since plugins may error out without it:
#   fzf      key bindings and ** completion (32-any-fzf)
#   zoxide   z / zi (33-any-zoxide)
#   tmux     aliases (34-any-tmux)
#   docker   aliases (37-mac-docker)
#   aws      completion and profile helpers (39-mac-aws-cli)
#   mise     activation and completion (40-mac-mise)
#   kubectl  aliases and completion (44-mac-kubectl)
#   helm     aliases and completion (45-mac-helm)
for _dot_plugin in fzf zoxide tmux docker aws mise kubectl helm; do
    if (( $+commands[${_dot_plugin}] )); then
        plugins+=("${_dot_plugin}")
    fi
done
unset _dot_plugin

if [[ -f "${ZSH}/oh-my-zsh.sh" ]]; then
    source "${ZSH}/oh-my-zsh.sh"
fi
