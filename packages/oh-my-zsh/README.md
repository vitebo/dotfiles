# oh-my-zsh

[oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh): zsh framework providing the
prompt (theme), plugins, completion (`compinit`), history options, key bindings
and common aliases.

- The framework is cloned to `~/.local/share/oh-my-zsh` (not with the official
  installer, which would replace `~/.zshrc`). It updates itself.
- `~/.config/zsh/22-oh-my-zsh.zsh` -> `config/22-oh-my-zsh.zsh`: the versioned config
  (theme, plugins), loaded by `~/.zshrc` like any package snippet. Defaults for now
  (`robbyrussell` theme, `git` plugin), plus the `fzf` / `zoxide` / `tmux` / `docker`
  / `aws` / `mise` / `kubectl` / `helm` plugins when their tool is installed
  ([fzf](../fzf), [zoxide](../zoxide),
  [tmux](../tmux), [docker](../docker),
  [aws-cli](../aws-cli), [mise](../mise),
  [kubectl](../kubectl), [helm](../helm)).

Personal aliases or options go in a package's own zsh snippet (`<NN>-<name>.zsh`,
loaded in `NN` order, after oh-my-zsh when its `NN` is above 22), not in `$ZSH_CUSTOM`.
Snippets that extend `fpath` need an `NN` below 22, since oh-my-zsh runs `compinit`.

Prerequisites:

- [zsh](../zsh)
- [git](../git)
