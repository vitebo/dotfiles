# 48-mac-openrig

Installs [OpenRig](https://github.com/mvschwarz/openrig) (`rig`, `openrig-tui`):
teams of coding agents (Claude Code here) with roles and shared context, each
agent running in a tmux session, viewed in herdr when it's installed.

- `~/.config/mise/conf.d/openrig.toml` -> `config/mise.toml`: the CLI as a mise tool
  (`npm:@openrig/cli`), installed by `install.sh` with mise's Node.js 22 (OpenRig
  needs 22 on Apple silicon) and kept across Node.js upgrades.
- `~/.config/zsh/48-openrig.zsh` -> `config/openrig.zsh`: OpenRig settings as
  `OPENRIG_*` variables (`~/.openrig/config.json` also holds the daemon's state and
  is rewritten by `rig config set`): Claude Code as the only provider.
- mac only: the agents run on the host.

## Integrations

- [34-any-tmux](../34-any-tmux): agents run in your tmux server
  (`terminal.tmux_server = inherit`, the default), with our config; they show up in
  `tl` / `prefix s`. `rig setup` always writes its block (mouse, `history-limit
  10000`) to `~/.tmux.conf`, which would shadow our XDG config: so `~/.tmux.conf`
  links to our `tmux.conf`, which already holds that block, and setup only replaces
  it in place (no diff).
- [47-mac-herdr](../47-mac-herdr): `rig terminal open ... --window` opens the
  OpenRig view in herdr when it's installed, plain tmux otherwise. Nothing to set up.
- [21-any-claude-code](../21-any-claude-code): OpenRig writes workspace trust to
  `~/.claude.json`, skills to `~/.claude/skills` / `~/.agents/skills`, and hooks to
  each project's `.claude/settings.local.json`: per machine / project, not versioned.

## First run (by hand, once per machine)

`install.sh` only installs the CLI. Setup also starts OpenRig's daemon and kernel
(its operator agent, with broad permissions on your home folder), so it's run by
hand, after `claude` is logged in:

```sh
rig setup --providers claude --no-herdr --no-ghostty   # herdr / Ghostty are already installed
rig daemon start
rig terminal open saved:kernel --window                # talk to the operator
```

`rig tui` is the team dashboard. Docs: https://github.com/mvschwarz/openrig

Prerequisites:

- [21-any-claude-code](../21-any-claude-code)
- [34-any-tmux](../34-any-tmux)
- [40-mac-mise](../40-mac-mise)
