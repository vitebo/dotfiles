# 28-any-bat

Installs [bat](https://github.com/sharkdp/bat), a `cat` clone with syntax
highlighting and git integration.

- `~/.config/bat/config` -> `config/config`: bat's default config
  (`bat --generate-config-file`).
- `~/.config/zsh/28-bat.zsh` -> `config/bat.zsh`, like gnugat:
  - `bat` alias to `batcat` on Debian/Ubuntu, where the binary is renamed;
  - colored man pages (`MANPAGER` through bat).

Unlike gnugat, no Catppuccin themes: bat's default theme for now.
