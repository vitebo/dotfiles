# 01-mac-homebrew

Installs [Homebrew](https://brew.sh) (when missing). Required by the other
packages' `_brew.sh` scripts.

- `~/.config/zsh/01-homebrew.zsh` -> `config/homebrew.zsh`: loads `brew shellenv`
  (PATH, completions...). No `~/.zprofile`: the shell env lives in `~/.zshrc` snippets.
