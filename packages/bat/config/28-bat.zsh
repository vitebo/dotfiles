# bat: `batcat` alias on Debian/Ubuntu, and colored man pages.

_dot_bat="bat"
if (( ! $+commands[bat] )) && (( $+commands[batcat] )); then
    alias bat="batcat"
    _dot_bat="batcat"
fi

if (( $+commands[${_dot_bat}] )) && (( $+commands[col] )); then
    export MANPAGER="sh -c 'col -bx | ${_dot_bat} -l man -p'"
    export MANROFFOPT="-c"
fi
unset _dot_bat
