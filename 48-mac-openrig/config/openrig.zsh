# OpenRig settings as environment variables (they override ~/.openrig/config.json,
# which also holds the daemon's state and is rewritten by `rig config set`).

(( $+commands[rig] )) || return 0

# Claude Code only: setup doesn't install / check Codex, the kernel only uses Claude.
export OPENRIG_PROVIDER_SELECTED="claude"
