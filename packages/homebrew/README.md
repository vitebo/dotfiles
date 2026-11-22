# homebrew

Installs [Homebrew](https://brew.sh) (when missing). Required by the other
packages' `_brew.sh` scripts.

- `~/.config/zsh/01-homebrew.zsh` -> `config/01-homebrew.zsh`: loads `brew shellenv`
  (PATH, completions...). No `~/.zprofile`: the shell env lives in `~/.zshrc` snippets.
- `uninstall.sh` runs Homebrew's official uninstaller: it removes Homebrew and
  **everything installed with it**, including packages that don't come from the
  dotfiles. In a profile uninstall it runs last.
