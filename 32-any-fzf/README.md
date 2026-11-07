# 32-any-fzf

Installs [fzf](https://github.com/junegunn/fzf), a command-line fuzzy finder.

## Usage

Key bindings and completion (oh-my-zsh's `fzf` plugin, enabled by
[22-any-oh-my-zsh](../22-any-oh-my-zsh) when fzf is installed):

- `ctrl-r`: search the shell history
- `ctrl-t`: insert files / directories from the current directory
- `alt-c`: `cd` into a directory
- `<command> **<tab>`: fuzzy completion, eg `nvim **<tab>`, `cd src/**<tab>`,
  `kill -9 **<tab>`, `ssh **<tab>`

In the finder: `ctrl-j` / `ctrl-k` (or `ctrl-n` / `ctrl-p`) to move, `tab` /
`shift-tab` to (un)select several, `enter` to accept, `esc` / `ctrl-c` to quit.

## Integrations

`~/.config/zsh/32-fzf.zsh` -> `config/fzf.zsh` (each one only when the
tool is installed):

- [30-any-fd](../30-any-fd) as source: hidden files included, `.git` and
  `.gitignore`'d files excluded.
- [28-any-bat](../28-any-bat) preview of the highlighted file (`ctrl-t`, `**`).
- [31-any-eza](../31-any-eza) tree preview of the highlighted directory (`alt-c`, `cd **`).

No color theme, and the oh-my-zsh plugin instead of `fzf --zsh`.
