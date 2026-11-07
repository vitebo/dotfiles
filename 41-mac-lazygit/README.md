# 41-mac-lazygit

Installs [lazygit](https://github.com/jesseduffield/lazygit), a terminal UI for git.

- `~/.config/lazygit/config.yml` -> `config/config.yml`: only our changes (none yet);
  lazygit's defaults apply for the rest (`lazygit --config` prints them).
- `~/.config/zsh/41-lazygit.zsh` -> `config/lazygit.zsh`: `lg` alias.
- mac only: git runs on the host (the project folder is shared with devcontainers).

## Integrations

- [29-any-git-delta](../29-any-git-delta): diffs rendered by delta. `config/delta.yml`
  is merged on top of `config.yml` through `LG_CONFIG_FILE`, only when delta is
  installed.
- [17-any-neovim](../17-any-neovim): files open in `$EDITOR` (nvim), no config needed.

Prerequisites:

- [12-any-git](../12-any-git)
