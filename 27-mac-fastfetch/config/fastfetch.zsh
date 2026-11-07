# Shows the system summary when a terminal opens, like gnugat's boot script.
# Only when the output is a terminal, so scripts and tools spawning a shell
# don't get it.

if [[ -t 1 ]] && (( $+commands[fastfetch] )); then
    fastfetch
fi
