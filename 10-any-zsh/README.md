# 10-any-zsh

- Installs zsh on linux (`_apt.sh`); on mac the system zsh is used.
- `~/.zshrc` -> `config/zshrc`, which loads `~/.config/zsh/<NN>-<name>.zsh`
  (snippets linked by each package with `_dot_link_zsh`, in package order),
  runs `compinit`, and last loads `~/.zshrc.local`.
- This package's own snippets: `config/{aliases,options,prompt}.zsh`.
- On linux, sets zsh as the default shell (`chsh`).

Machine specific config goes in `~/.zshrc.local` (out of the repo).
