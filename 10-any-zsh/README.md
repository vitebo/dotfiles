# 10-any-zsh

- Installs zsh on linux (`_apt.sh`); on mac the system zsh is used.
- `~/.zshrc` -> `config/zshrc`, which loads `~/.config/zsh/*.zsh`
  (each `config/*.zsh` is symlinked there) and, last, `~/.zshrc.local`.
- On linux, sets zsh as the default shell (`chsh`).

Machine specific config goes in `~/.zshrc.local` (out of the repo).
