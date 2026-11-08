# 47-mac-herdr

Installs [herdr](https://github.com/herdrdev/herdr), a terminal workspace manager
for AI coding agents: persistent sessions (detach / reattach), panes marked
working / blocked / idle, and a CLI / socket API agents can drive.

- `~/.config/herdr/config.toml` -> `config/config.toml`: only our changes
  (`herdr --default-config` prints the defaults, `herdr config check` validates):
  `theme.name = "terminal"`, following Ghostty's palette, so Catppuccin Latte or
  Mocha with macOS (rather than `auto_switch` between herdr's built-in Catppuccin
  themes: the terminal's colors come first, see CLAUDE.md "Themes").
- Prefix `ctrl+b`, the default, like tmux ([34-any-tmux](../34-any-tmux)): use one
  or the other in a terminal, don't nest them.
- herdr writes `onboarding = false` to its config once the first-run setup is
  done: commit that diff.
- mac only: the agents run on the host.

## Claude Code integration

What `herdr integration install claude` would write, versioned so it works on
every machine:

- `~/.claude/hooks/herdr-agent-state.sh` -> `config/claude-hook.sh`: the hook
  (managed by herdr, integration v11). It does nothing outside a herdr pane.
- [21-any-claude-code](../21-any-claude-code)'s `settings.json` runs it on
  `SessionStart` through `$HOME` (herdr would write an absolute path), and only when
  the file exists (machines / devcontainers without herdr).

It reports the Claude session to herdr, so herdr can resume it after its server
restarts; the working / blocked / idle state works without it. After upgrading
herdr, check `herdr integration status`: if outdated, run
`herdr integration install claude`, commit the new `claude-hook.sh`, and revert the
command it writes in `settings.json` back to the `$HOME` one.

Usage: `herdr` starts / reattaches, `ctrl+b q` detaches. Docs: https://herdr.dev/docs/
