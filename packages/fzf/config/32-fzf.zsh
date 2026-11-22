# fzf integrations with other packages: fd (packages/fd) as source,
# bat (packages/bat) and eza (packages/eza) for previews. Each one only when its tool
# is installed. Key bindings and ** completion come from oh-my-zsh's fzf plugin
# (packages/oh-my-zsh).
#
# fzf runs these commands outside zsh, where aliases don't apply: use the real
# binary names (Debian/Ubuntu rename fd and bat to fdfind and batcat).

(( $+commands[fzf] )) || return 0

_dot_fzf_fd=""
if (( $+commands[fd] )); then
    _dot_fzf_fd="fd"
elif (( $+commands[fdfind] )); then
    _dot_fzf_fd="fdfind"
fi

_dot_fzf_bat=""
if (( $+commands[bat] )); then
    _dot_fzf_bat="bat"
elif (( $+commands[batcat] )); then
    _dot_fzf_bat="batcat"
fi

# bat's `ansi` theme: inside fzf, bat can't ask the terminal for its background,
# and the 16 ANSI colors follow Ghostty's Catppuccin flavor anyway.
_dot_fzf_bat_preview="${_dot_fzf_bat} -n --color=always --theme=ansi --line-range :500 {}"
_dot_fzf_eza_preview="eza --tree --color=always {} | head -n 200"

# Colors: the terminal's 16 ANSI colors (fzf's `base16` scheme) instead of its
# fixed dark 256-color scheme, so fzf follows Ghostty's Catppuccin Latte / Mocha.
# (Not again in nested shells, which inherit the exported variable.)
if [[ " ${FZF_DEFAULT_OPTS} " != *" --color=16 "* ]]; then
    export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+${FZF_DEFAULT_OPTS} }--color=16"
fi

# Source: fd, with hidden files, without .git and .gitignore'd files.
if [[ -n "${_dot_fzf_fd}" ]]; then
    export FZF_DEFAULT_COMMAND="${_dot_fzf_fd} --hidden --strip-cwd-prefix --exclude .git"
    export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
    export FZF_ALT_C_COMMAND="${_dot_fzf_fd} --type=d --hidden --strip-cwd-prefix --exclude .git"

    # ** completion
    _fzf_compgen_path() {
        "${_dot_fzf_fd}" --hidden --exclude .git . "$1"
    }
    _fzf_compgen_dir() {
        "${_dot_fzf_fd}" --type=d --hidden --exclude .git . "$1"
    }
fi

# Previews: bat for files (ctrl-t), eza for directories (alt-c).
if [[ -n "${_dot_fzf_bat}" ]]; then
    export FZF_CTRL_T_OPTS="--preview '${_dot_fzf_bat_preview}'"
fi
if (( $+commands[eza] )); then
    export FZF_ALT_C_OPTS="--preview '${_dot_fzf_eza_preview}'"
fi

# ** completion previews: eza for `cd`, bat for the other commands.
_fzf_comprun() {
    local command="$1"
    shift

    if [[ "${command}" == "cd" ]] && (( $+commands[eza] )); then
        fzf --preview "${_dot_fzf_eza_preview}" "$@"
    elif [[ "${command}" != "cd" ]] && [[ -n "${_dot_fzf_bat}" ]]; then
        fzf --preview "${_dot_fzf_bat_preview}" "$@"
    else
        fzf "$@"
    fi
}
