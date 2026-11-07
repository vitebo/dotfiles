# Simple prompt: [host when in a container] directory (git branch) %
#   The % turns red when the last command failed.

autoload -Uz vcs_info add-zsh-hook
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{magenta}(%b)%f'
add-zsh-hook precmd vcs_info
setopt PROMPT_SUBST

_dot_prompt_host=''
if [[ -f /.dockerenv || -f /run/.containerenv ]]; then
    _dot_prompt_host='%F{yellow}%m%f '
fi

PROMPT="${_dot_prompt_host}"'%F{blue}%~%f${vcs_info_msg_0_} %(?.%F{green}.%F{red})%#%f '
unset _dot_prompt_host
