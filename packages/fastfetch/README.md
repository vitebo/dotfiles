# fastfetch

Installs [fastfetch](https://github.com/fastfetch-cli/fastfetch), a system
information summary, and shows it when a terminal opens.

- `~/.config/fastfetch/config.jsonc` -> `config/config.jsonc`: fastfetch's default
  config (`fastfetch --gen-config`).
- `~/.config/zsh/27-fastfetch.zsh` -> `config/27-fastfetch.zsh`: runs `fastfetch` in
  interactive shells whose output is a terminal.

mac only: in a devcontainer it would only describe the container.
