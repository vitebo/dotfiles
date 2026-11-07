# 42-mac-lazydocker

Installs [lazydocker](https://github.com/jesseduffield/lazydocker), a terminal UI
for docker and docker compose.

- `~/.config/lazydocker/config.yml` -> `config/config.yml`: only our changes (none
  yet); lazydocker's defaults apply for the rest (`lazydocker --config` prints them).
- `~/.config/zsh/42-lazydocker.zsh` -> `config/lazydocker.zsh`: `lzd` alias.
- mac only, like docker.

Prerequisites:

- [37-mac-docker](../37-mac-docker)
