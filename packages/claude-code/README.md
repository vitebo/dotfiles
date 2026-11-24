# claude-code

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
  - `browser.md`: chrome-devtools MCP by default, Claude in Chrome (sessions
    started with `claude --chrome`) only for flows that need the real, logged-in
    Chrome (Turnstile / CAPTCHAs, SSO); setup in
    [google-chrome](../google-chrome)
  - `devcontainer.md`: when a project has a devcontainer, run project commands
    (tests, lint, build, servers...) inside it with the devcontainer CLI, while
    Claude itself runs on the host
- `~/.config/zsh/21-claude-code.zsh` -> `config/21-claude-code.zsh`: puts `~/.local/bin` first in PATH
- `settings.json` [agent teams](https://code.claude.com/docs/en/agent-teams)
  (experimental): enabled with `env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`, and
  `"teammateMode": "tmux"` gives each teammate its own [tmux](../tmux) pane: in
  Claude's window when it runs inside tmux, else in a separate tmux session (the
  `View teammates` line shows how to attach). Ghostty has no split-pane support
  of its own. Background sessions (dispatched from agent view, `claude --bg`, or
  moved there with `←`) run under Claude Code's daemon, outside any tmux pane,
  so their teammates always go to that separate session: start the lead as a
  plain `claude` in the pane to get them as splits of its window.
- `settings.json` `"preferredNotifChannel": "ghostty"`: desktop notifications
  (task done, permission prompt) as Ghostty's, also inside tmux, where Claude Code
  can't detect Ghostty (tmux passes them through, see [tmux](../tmux)).
- `settings.json` `"agentPushNotifEnabled"` / `"inputNeededNotifEnabled"`: push
  notifications to the phone (Claude app) when an agent finishes and when it needs
  input; a no-op on machines without the app logged in.
- `settings.json` `"language": "PT-BR"`: Claude replies in Brazilian Portuguese.
  Its injected instruction also mentions comments, so `config/CLAUDE.md` keeps
  saying code, comments and commits are in English (more specific, it wins there).
- `settings.json` `"editorMode": "vim"`: vim keys in the prompt (`esc` for NORMAL
  mode, `hjkl`, `v`, `d` / `c` / `y` with text objects); `enter` still submits in
  INSERT mode, `o` / `O` or `ctrl+j` add a line.
  [Reference](https://code.claude.com/docs/en/interactive-mode.md#vim-editor-mode).
- `~/.claude/statusline.sh` -> `config/statusline.sh`: the status line
  (`settings.json` `statusLine`, run through `$HOME` only when the file exists).
  Styled after [cc-hud](https://github.com/WaterTian/cc-hud), but a jq script (no
  Node.js, no OAuth token read, ANSI colors that follow the terminal's theme): a
  context bar, the plan usage of the 5-hour and 7-day windows with the time to
  reset, and the effort level, with nerd font icons:
  `󰧑  ████▍░░░░░ 44% │ 󰔟 5h:72% (1.5h) │ 󰃭 7d:26% (3.5d) │ 󰓅 medium`.
  A line holding a braille blank (U+2800, since Claude Code drops
  whitespace-only lines) above and below it leaves a small gap around it.
  Claude Code only sends the plan usage for claude.ai subscriptions, after the
  session's first response; until then those segments are hidden. When a window
  resets, Claude Code drops it until the next response, so it shows as `—%`. With a status
  line, Claude Code hides most footer hints (eg `esc to interrupt`).
- `settings.json` hooks: `UserPromptSubmit` / `PostToolUse` (working),
  `PermissionRequest` / `Notification` for permission prompts and MCP questions
  (needs you), `Stop` / `StopFailure` (done) and `SessionEnd` (cleared) run
  [tmux](../tmux)'s `~/.claude/hooks/tmux-agent-state.sh`, only when
  it exists, so tmux shows which agents need you.
- `settings.json` `"theme": "auto"` ("Auto (match terminal)" in `/theme`): Claude
  Code has no Catppuccin theme, so it uses its own light or dark one, following
  the terminal's mode (Ghostty follows macOS).

Claude Code writes `settings.json` itself (`/config`, `/model`, `/effort`...), and
there's no user-level local file for per-machine values. A git clean filter
(`git-clean-settings.sh`, wired in the root `.gitattributes`, set up in the repo's
`.git/config` by `install.sh`) drops the per-machine keys (`model`,
`effortLevel`, `modelSettings`) and sorts the top-level keys on `git add`: those
stay in the linked file on this machine and never show up as a diff. Other
changes still show up: commit them if they apply to every machine, otherwise
revert them and set them locally (below). A checkout that changes `settings.json`
(eg a pull) rewrites the file without the per-machine keys, so they're picked
again with `/model` / `/effort`.

## Per-machine config (out of the repo)

- **Account / login**: `~/.claude.json` and the OS keychain, per machine. Each
  machine logs in with its own account (`claude` → `/login`).
- **Organization policy** (work): managed settings deployed by the company apply
  on top of everything, nothing to do here.
- **Machine-only instructions**: plain files in `~/.claude/rules/` (eg
  `work-<topic>.md`), next to the linked shared ones.
- **Machine-only env vars** (eg `CLAUDE_CODE_*`, `ANTHROPIC_*`): `~/.zshrc.local`.

Prerequisites: [curl](../curl) (linux).
