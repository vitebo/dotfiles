# 34-any-tmux

Installs [tmux](https://github.com/tmux/tmux), a terminal multiplexer: sessions
that survive closing the terminal, with windows (tabs) and panes (splits).

- `~/.config/tmux/tmux.conf` -> `config/tmux.conf`: tmux defaults (prefix
  `Ctrl+b`) plus a few essentials marked `dotfiles:` (mouse, numbering from 1,
  splits in the current directory, `prefix h/j/k/l` for panes, vim copy mode,
  clipboard through the terminal, `prefix r` to reload, 10ms escape time).
  No theme or plugins (gnugat uses Catppuccin and TPM).
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
