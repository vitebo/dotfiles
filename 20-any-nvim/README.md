# 20-any-nvim

[Neovim](https://neovim.io) with [NvChad](https://nvchad.com).

- Installs Neovim (0.11+), ripgrep and tree-sitter-cli.
  - mac: brew, plus the JetBrainsMono Nerd Font.
  - linux: build tools and ripgrep via apt; Neovim and tree-sitter from their
    GitHub releases (apt's Neovim is too old).
- `~/.config/nvim` -> `config/nvim`: the [NvChad starter](https://github.com/NvChad/starter),
  versioned here so changes can be tracked. `lazy-lock.json` pins the plugin versions.
- `~/.config/zsh/nvim.zsh` -> `config/nvim.zsh`: sets `EDITOR` / `VISUAL`.

After the first install, run `:MasonInstallAll` inside nvim to install the
language servers and formatters.

The terminal must use a Nerd Font (eg JetBrainsMono Nerd Font) for icons to render.
In a devcontainer, that's the host terminal's font.

Update plugins with `:Lazy sync`, then commit the new `lazy-lock.json`.
