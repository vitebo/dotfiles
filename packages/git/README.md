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
- Last, it includes `~/.config/git/config.local`, a machine-only file that isn't
  versioned (ignored when missing). Use it for per-machine overrides, eg the work
  identity on the work MacBook:

  ```sh
  git config --file ~/.config/git/config.local user.name andre.vitebo
  git config --file ~/.config/git/config.local user.email <work email>
  ```
