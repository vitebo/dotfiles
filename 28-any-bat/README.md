# 28-any-bat

Installs [bat](https://github.com/sharkdp/bat), a `cat` clone with syntax
highlighting and git integration.

- `~/.config/bat/config` -> `config/config`: bat's default config
  (`bat --generate-config-file`), plus the theme: Catppuccin Latte on a light
  terminal, Mocha on a dark one (bat asks the terminal each run; Mocha when it
  can't).
- `~/.config/zsh/28-bat.zsh` -> `config/bat.zsh`:
  - `bat` alias to `batcat` on Debian/Ubuntu, where the binary is renamed;
  - colored man pages (`MANPAGER` through bat).

