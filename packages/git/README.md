# git

Installs git on linux. On macOS it comes with the Xcode Command Line Tools
(installed alongside Homebrew).

- `~/.config/git/config` -> `config/config`: global git config, including the
  identity (`[user]`). XDG location instead of `~/.gitconfig`, which must not
  exist (it would be read on top of this one).
- It includes `~/.config/git-delta/git-delta.config` from
  [git-delta](../git-delta), ignored when that package isn't installed.
- It includes `~/.config/gh/git-credential.config` from [gh](../gh)
  (gh's login for https on github.com), ignored the same way.
