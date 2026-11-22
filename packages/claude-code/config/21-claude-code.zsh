# Claude Code native install lives in ~/.local/bin.

if [[ -d "${HOME}/.local/bin" ]]; then
    path=("${HOME}/.local/bin" ${path:#${HOME}/.local/bin})
fi
