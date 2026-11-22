# lazygit

Installs [lazygit](https://github.com/jesseduffield/lazygit), a terminal UI for git.

- `~/.config/lazygit/config.yml` -> `config/config.yml`: only our changes (none yet);
  lazygit's defaults apply for the rest (`lazygit --config` prints them).
- `~/.config/zsh/41-lazygit.zsh` -> `config/41-lazygit.zsh`: `lg` alias.
- mac only: git runs on the host (the project folder is shared with devcontainers).

## Integrations

- [git-delta](../git-delta): diffs rendered by delta. `config/delta.yml`
  is merged on top of `config.yml` through `LG_CONFIG_FILE`, only when delta is
  installed.
- [neovim](../neovim): files open in `$EDITOR` (nvim), no config needed.

Colors: lazygit's default theme, made of the terminal's ANSI colors, so it follows
Ghostty's Catppuccin Latte / Mocha.

Prerequisites:

- [git](../git)
