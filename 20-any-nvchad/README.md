# 20-any-nvchad

[NvChad](https://nvchad.com) configuration for Neovim.

- `~/.config/nvim` -> `config/nvim`: the [NvChad starter](https://github.com/NvChad/starter),
  versioned here so changes can be tracked. `lazy-lock.json` pins the plugin versions.
- Installs the pinned plugins headlessly, so the first launch is ready to use.

Prerequisites (installed by their own packages, which run first):

- [12-any-git](../12-any-git)
- [13-any-build-tools](../13-any-build-tools)
- [14-any-unzip](../14-any-unzip)
- [15-any-ripgrep](../15-any-ripgrep)
- [16-any-tree-sitter](../16-any-tree-sitter)
- [17-any-neovim](../17-any-neovim)
- [18-mac-nerd-font](../18-mac-nerd-font) (mac; in a devcontainer, the host terminal's font)

After the first install, run `:MasonInstallAll` inside nvim to install the
language servers and formatters.

Update plugins with `:Lazy sync`, then commit the new `lazy-lock.json`.
