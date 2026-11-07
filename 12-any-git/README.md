# 12-any-git

Installs git on linux. On macOS it comes with the Xcode Command Line Tools
(installed alongside Homebrew).

- `~/.config/git/config` -> `config/config`: global git config, including the
  identity (`[user]`). XDG location instead of `~/.gitconfig`, which must not
  exist (it would be read on top of this one).
