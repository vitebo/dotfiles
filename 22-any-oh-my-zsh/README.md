# 22-any-oh-my-zsh

[oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh): zsh framework providing the
prompt (theme), plugins, completion (`compinit`), history options, key bindings
and common aliases.

- The framework is cloned to `~/.local/share/oh-my-zsh` (not with the official
  installer, which would replace `~/.zshrc`). It updates itself.
- `~/.config/zsh/22-oh-my-zsh.zsh` -> `config/oh-my-zsh.zsh`: the versioned config
  (theme, plugins), loaded by `~/.zshrc` like any package snippet. Defaults for now
  (`robbyrussell` theme, `git` plugin).

Personal aliases or options go in a package's own zsh snippet (loaded in package
order, after oh-my-zsh when the package `NN` is higher), not in `$ZSH_CUSTOM`.
Packages that extend `fpath` need a lower `NN`, since oh-my-zsh runs `compinit`.

Prerequisites:

- [10-any-zsh](../10-any-zsh)
- [12-any-git](../12-any-git)
