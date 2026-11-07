# fd: Debian/Ubuntu ship it as `fdfind` (name clash), alias it back to `fd`.

if (( ! $+commands[fd] )) && (( $+commands[fdfind] )); then
    alias fd="fdfind"
fi
