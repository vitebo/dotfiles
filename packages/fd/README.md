# fd

Installs [fd](https://github.com/sharkdp/fd), a simple, fast and user-friendly
alternative to `find` (respects `.gitignore`, skips hidden files by default).

- `~/.config/zsh/30-fd.zsh` -> `config/30-fd.zsh`: `fd` alias to `fdfind` on
  Debian/Ubuntu, where the binary is renamed.

Examples: `fd readme`, `fd -e sh`, `fd -H -t f zshrc` (hidden files, files only).
