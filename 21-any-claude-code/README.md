# 21-any-claude-code

Installs [Claude Code](https://code.claude.com) with the native installer
(`~/.local/bin/claude`, auto-updates), on mac and linux.

## Config shared across machines

The same config is used on every machine (personal and work), whatever account
is logged in:

- `~/.claude/settings.json` -> `config/settings.json`
- `~/.claude/CLAUDE.md` -> `config/CLAUDE.md`: personal instructions (communication,
  working style)
- `~/.claude/rules/<name>.md` -> `config/rules/<name>.md` (each file linked on its own):
  - `git.md`: Conventional Commits, commit/push etiquette
  - `devcontainer.md`: when a project has a devcontainer, run project commands
    (tests, lint, build, servers...) inside it with the devcontainer CLI, while
    Claude itself runs on the host
- `~/.config/zsh/21-claude-code.zsh` -> `config/claude-code.zsh`: puts `~/.local/bin` first in PATH
- `settings.json` hooks: `SessionStart` runs herdr's hook
  (`~/.claude/hooks/herdr-agent-state.sh`, from [47-mac-herdr](../47-mac-herdr)) only
  when it exists, so machines without herdr are unaffected.
- `settings.json` Orca hooks (every other event, plus the second `SessionStart`) and
  `statusLine`: written by [51-mac-orca](../51-mac-orca) on launch and committed as
  is. They run the scripts in `~/.orca/agent-hooks/` only when they exist, and those
  exit right away outside Orca.
- `settings.json` `"theme": "auto"` ("Auto (match terminal)" in `/theme`): Claude
  Code has no Catppuccin theme, so it uses its own light or dark one, following
  the terminal's mode (Ghostty follows macOS).

Claude Code writes `settings.json` itself (`/config`, `/model`...): those changes
show up as a diff in this repo. Commit them if they apply to every machine,
otherwise revert them and set them locally (below).

## Per-machine config (out of the repo)

- **Account / login**: `~/.claude.json` and the OS keychain, per machine. Each
  machine logs in with its own account (`claude` → `/login`).
- **Organization policy** (work): managed settings deployed by the company apply
  on top of everything, nothing to do here.
- **Machine-only instructions**: plain files in `~/.claude/rules/` (eg
  `work-<topic>.md`), next to the linked shared ones.
- **Machine-only env vars** (eg `CLAUDE_CODE_*`, `ANTHROPIC_*`): `~/.zshrc.local`.

Prerequisites: [11-any-curl](../11-any-curl) (linux).
