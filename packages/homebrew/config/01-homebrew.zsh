# Homebrew env: PATH, MANPATH, completions (fpath)...

for _dot_brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x "${_dot_brew}" ]]; then
        eval "$("${_dot_brew}" shellenv zsh)"
        break
    fi
done
unset _dot_brew
