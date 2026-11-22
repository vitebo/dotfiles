# neovim

Installs [Neovim](https://neovim.io) (`nvim`) and makes it the default editor.

- mac: brew.
- linux: latest GitHub release in `/opt/nvim` (apt's version is too old).
- `~/.config/zsh/17-neovim.zsh` -> `config/17-neovim.zsh`: sets `EDITOR` / `VISUAL`.

The editor configuration lives in its own package (eg [nvchad](../nvchad)).

Prerequisites: [curl](../curl) (linux).
