# 34-any-tmux

Installs [tmux](https://github.com/tmux/tmux), a terminal multiplexer: sessions
that survive closing the terminal, with windows (tabs) and panes (splits).

- `~/.config/tmux/tmux.conf` -> `config/tmux.conf`: tmux defaults (prefix
  `Ctrl+b`) plus a few essentials marked `dotfiles:` (mouse, numbering from 1,
  splits in the current directory, `prefix h/j/k/l` for panes, vim copy mode,
  clipboard through the terminal, `prefix r` to reload, 10ms escape time).
  No theme or plugins.
- `~/.config/tmux/status-line.conf` -> `config/status-line.conf`: status line at the
  top: current session, windows and user, with rounded edges (`prefix s` lists
  all the sessions).
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
  [54-any-chafa](../54-any-chafa) shows real images (kitty graphics) inside tmux,
  and Claude Code's desktop notifications reach Ghostty.
- Claude Code agents that need you: `~/.claude/hooks/tmux-agent-state.sh` ->
  `config/claude-hook.sh`, run by Claude Code's hooks
  ([21-any-claude-code](../21-any-claude-code)), records each pane's Claude state
  in tmux options (`@claude_pane`, and the most urgent one in `@claude_window` /
  `@claude_session`): `working` (prompt sent, tool done), `attention` (permission
  prompt, MCP question), `done` (turn finished) and `read` (a `done` pane you've
  looked at: tmux's `pane-focus-in` hook, or the turn ended while you were watching
  it). It does nothing outside tmux.
  - Status line: an icon before each window's name (bell = needs you, check = done,
    double check = read, hourglass = working); other windows needing you are drawn on red, and other
    sessions needing you are listed on the right, on red.
  - `prefix + a`: lists only the panes waiting for you (`attention`, or `done` not
    read yet), zoomed; Enter jumps there. Sessions show up once their Claude has
    run a hook (after your next message there).
- `focus-events on`: apps learn when the terminal gains / loses focus (Claude Code
  uses it to notify you when you're away). With extended keys and passthrough, this
  is the tmux setup [Claude Code's terminal docs](https://code.claude.com/docs/en/terminal-config.md)
  recommend.
- `~/.config/zsh/34-tmux.zsh` -> `config/tmux.zsh`: `tz <query>` opens (or goes
  back to) a session in the directory [33-any-zoxide](../33-any-zoxide) finds,
  named after it.
- oh-my-zsh's `tmux` plugin ([22-any-oh-my-zsh](../22-any-oh-my-zsh)), when tmux
  is installed: `ta <name>` attach, `ts <name>` new session, `tl` list, `tds` session
  named after the current directory, `tkss <name>` kill a session, `tksv` kill all.

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
| `prefix [` | copy mode: `v` select, `y` copy, `q` quit; also to scroll back |
| `prefix r` | reload the config |
| `prefix ?` | list all bindings |

Prerequisites: none ([33-any-zoxide](../33-any-zoxide) for `tz`).
