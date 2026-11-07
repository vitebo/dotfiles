# 31-any-eza

Installs [eza](https://github.com/eza-community/eza), a modern alternative to `ls`,
and uses it for the listing aliases (one level as a tree, like gnugat):

| Alias | Lists |
| --- | --- |
| `l` | files |
| `la` | files, including hidden ones |
| `ll` | long format: permissions, size, user, group, date, git status |
| `lla` | long format, including hidden files |

- `~/.config/zsh/31-eza.zsh` -> `config/eza.zsh`: the aliases, only when `eza` is
  installed. `NN` is above [22-any-oh-my-zsh](../22-any-oh-my-zsh), so they replace
  its `l` / `la` / `ll`; without eza, oh-my-zsh's (`ls`) ones apply.
- Icons need a Nerd Font in the terminal ([18-mac-nerd-font](../18-mac-nerd-font)).
- Unlike gnugat: colors and icons are `auto` (plain text when piped), no theme.
