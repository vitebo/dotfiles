# eza

Installs [eza](https://github.com/eza-community/eza), a modern alternative to `ls`,
and uses it for the listing aliases (one level as a tree):

| Alias | Lists |
| --- | --- |
| `l` | files |
| `la` | files, including hidden ones |
| `ll` | long format: permissions, size, user, group, date, git status |
| `lla` | long format, including hidden files |

- `~/.config/zsh/31-eza.zsh` -> `config/31-eza.zsh`: the aliases, only when `eza` is
  installed. Its `NN` (31) is above [oh-my-zsh](../oh-my-zsh)'s (22), so they replace
  its `l` / `la` / `ll`; without eza, oh-my-zsh's (`ls`) ones apply.
- Icons need a Nerd Font in the terminal ([nerd-font](../nerd-font)).
- Colors and icons are `auto` (plain text when piped), no theme: eza's colors
  are the terminal's ANSI ones, so they follow Ghostty's Catppuccin flavor.
