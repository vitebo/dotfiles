# tmux

Installs [tmux](https://github.com/tmux/tmux), a terminal multiplexer: sessions
that survive closing the terminal, with windows (tabs) and panes (splits).

- `~/.config/tmux/tmux.conf` -> `config/tmux.conf`: tmux defaults (prefix
  `Ctrl+b`) plus a few essentials marked `dotfiles:` (mouse, numbering from 1,
  splits in the current directory, `prefix h/j/k/l` for panes, vim copy mode,
  clipboard through the terminal, `prefix r` to reload, 10ms escape time).
  No theme; plugins below.
- `~/.config/tmux/status-line.conf` -> `config/status-line.conf`: status line at the
  top: current session, windows and the current kubectl context (cluster name
  only, refreshed every 15s, hidden without kubectl or a context; see
  [kubectl](../kubectl)), with rounded edges (`prefix s` lists all
  the sessions).
  Catppuccin colors, Latte or Mocha following the light / dark mode the terminal
  reports (Ghostty follows macOS), switched live: the `@dot_*` options at the top
  of the file pick each role's color from `client_theme`, and tmux's theme colours
  (`light-theme-*` / `dark-theme-*`) hold the Catppuccin ones; tmux's messages,
  menus and copy mode use the grey ones, readable in both. A terminal that doesn't
  report its background gets Mocha.
- Apps inside tmux follow the terminal's light / dark mode too: tmux answers their
  DSR 996 queries and forwards mode 2031 change reports (after re-reading the
  terminal's background, which Ghostty answers).
- `allow-passthrough on`: apps can send sequences straight to the terminal, so
  [chafa](../chafa) shows real images (kitty graphics) inside tmux,
  and Claude Code's desktop notifications reach Ghostty.
- Claude Code agents that need you: `~/.claude/hooks/tmux-agent-state.sh` ->
  `config/claude-hook.sh`, run by Claude Code's hooks
  ([claude-code](../claude-code)), records each pane's Claude state
  in tmux options (`@claude_pane`, and the most urgent one in `@claude_window` /
  `@claude_session`). It does nothing outside tmux.
  - States, most urgent first (a window or session shows its most urgent pane):

    | Icon | State | Meaning | Set by |
    | :-: | - | - | - |
    | 󰂞 bell | `attention` | Claude is blocked on you: a permission prompt or an MCP question. Looking at it doesn't clear it, answering does | `PermissionRequest`, `Notification` (permission / MCP prompts) |
    | 󰄬 check | `done` | Claude finished its turn and waits for your next message; you haven't looked at it yet | `Stop`, `StopFailure` |
    | 󰔟 hourglass | `working` | Claude is working: you sent a prompt, or a tool just ran (eg right after you approved it) | `UserPromptSubmit`, `PostToolUse` |
    | 󰄭 double check | `read` | A `done` turn you've already seen: you focused its pane, or it finished while you were watching it | tmux's `pane-focus-in` hook, `Stop` |
    | 󰧟 dot | none | Claude runs there but hasn't run a hook yet (started before the hooks, or idle since); `prefix + a` only | `prefix + a` finds its `claude` process |

    The state is cleared when the session ends (`SessionEnd`).
  - Status line: the state icon before each window's name; other windows in
    `attention` are drawn on red, and other sessions in `attention` are listed on the
    right, on red.
  - `prefix + a`: a menu (`~/.config/tmux/claude-agents.sh` ->
    `config/claude-agents.sh`) with every pane running Claude Code, found by its
    `claude` process: state icon (a dot until it runs a hook), session and window,
    and Claude's session title. The ones that need you come first, then done, working
    and read; Enter or the item's number jumps there.
- `focus-events on`: apps learn when the terminal gains / loses focus (Claude Code
  uses it to notify you when you're away). With extended keys and passthrough, this
  is the tmux setup [Claude Code's terminal docs](https://code.claude.com/docs/en/terminal-config.md)
  recommend.
- `~/.config/zsh/34-tmux.zsh` -> `config/34-tmux.zsh`: `tz <query>` opens (or goes
  back to) a session in the directory [zoxide](../zoxide) finds,
  named after it.
- oh-my-zsh's `tmux` plugin ([oh-my-zsh](../oh-my-zsh)), when tmux
  is installed: `ta <name>` attach, `ts <name>` new session, `tl` list, `tds` session
  named after the current directory, `tkss <name>` kill a session, `tksv` kill all.

- Plugins, through [TPM](https://github.com/tmux-plugins/tpm): `install.sh` clones
  each `@plugin` of `tmux.conf` into `~/.local/share/tmux/plugins` (outside the repo,
  like oh-my-zsh); `prefix + I` / `prefix + U` install / update them by hand.
  - [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect): saves and
    restores sessions, windows, panes (layout, current directory) and some programs:
    nvim (with its arguments, eg `nvim .`, without its open buffers), lazygit, and
    Claude Code, reopened as `claude --continue` (its latest conversation in that
    directory). Saves go in `~/.local/share/tmux/resurrect`, not versioned. Pane
    contents (the text on screen) aren't saved.
  - [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum): saves every 15
    minutes, and restores the last save when the tmux server starts, eg the first
    `tmux` after a reboot. The Claude states (bell, check...) aren't restored: they
    come back on each agent's next hook.

## Cheatsheet

`prefix` is `Ctrl+b`: press it, release, then press the key.

| Keys | Action |
| --- | --- |
| `prefix d` | detach (the session keeps running; `ta` / `tmux attach` to come back) |
| `prefix s` | list sessions to switch to |
| `prefix $` | rename the session |
| `prefix c` | new window |
| `prefix 1` … `9` | go to window |
| `prefix n` / `p` / `L` | next / previous / last window |
| `prefix ,` | rename the window |
| `prefix %` / `"` | split left-right / top-bottom |
| `prefix h/j/k/l` | move between panes (or click) |
| `prefix z` | zoom the pane in / out |
| `prefix x` | close the pane (or `exit`) |
| `prefix X` | kill the session (asks first); you land in another session |
| `prefix [` | copy mode: `v` select, `y` copy, `q` quit; also to scroll back |
| `prefix r` | reload the config |
| `prefix Ctrl-s` / `prefix Ctrl-r` | save / restore sessions (tmux-resurrect) |
| `prefix a` | menu of Claude Code agents |
| `prefix ?` | list all bindings |

Prerequisites: [git](../git) (plugins); [zoxide](../zoxide) for `tz`.
