# 26-any-tree

Installs [tree](https://oldmanprogrammer.net/source.php?dir=projects/tree) and,
like gnugat, uses it for the listing aliases (one level deep):

| Alias | Command |
| --- | --- |
| `l` | `tree -L 1` |
| `la` | `tree -a -L 1` (hidden files) |
| `ll` | `tree -hDpug -L 1` (size, date, permissions, user, group) |
| `lla` | `tree -ahDpug -L 1` |

- `~/.config/zsh/26-tree.zsh` -> `config/tree.zsh`: the aliases. `NN` is above
  [22-any-oh-my-zsh](../22-any-oh-my-zsh), so they replace oh-my-zsh's `l` / `la` / `ll`.
