# 17-any-neovim

Installs [Neovim](https://neovim.io) (`nvim`) and makes it the default editor.

- mac: brew.
- linux: latest GitHub release in `/opt/nvim` (apt's version is too old).
- `~/.config/zsh/neovim.zsh` -> `config/neovim.zsh`: sets `EDITOR` / `VISUAL`.

The editor configuration lives in its own package (eg [20-any-nvchad](../20-any-nvchad)).

Prerequisites: [11-any-curl](../11-any-curl) (linux).
