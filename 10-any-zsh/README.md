# 10-any-zsh

The shell itself and its loader; the shell setup (prompt, completion, history,
aliases...) comes from [22-any-oh-my-zsh](../22-any-oh-my-zsh).

- Installs zsh on linux (`_apt.sh`); on mac the system zsh is used.
- `~/.zshrc` -> `config/zshrc`, which loads `~/.config/zsh/<NN>-<name>.zsh`
  (snippets linked by each package with `_dot_link_zsh`, in package order) and,
  last, `~/.zshrc.local`.
- On linux, sets zsh as the default shell (`chsh`).

Machine specific config goes in `~/.zshrc.local` (out of the repo).
