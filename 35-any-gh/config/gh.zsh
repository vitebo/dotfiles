# gh pages its output (eg `gh pr diff`) through delta (29-any-git-delta) when it's
# installed, like git does.

if (( $+commands[gh] )) && (( $+commands[delta] )); then
    export GH_PAGER="delta"
fi
