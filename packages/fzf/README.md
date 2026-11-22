# fzf

Installs [fzf](https://github.com/junegunn/fzf), a command-line fuzzy finder.

## Usage

Key bindings and completion (oh-my-zsh's `fzf` plugin, enabled by
[oh-my-zsh](../oh-my-zsh) when fzf is installed):

- `ctrl-r`: search the shell history
- `ctrl-t`: insert files / directories from the current directory
- `alt-c`: `cd` into a directory
- `<command> **<tab>`: fuzzy completion, eg `nvim **<tab>`, `cd src/**<tab>`,
  `kill -9 **<tab>`, `ssh **<tab>`

In the finder: `ctrl-j` / `ctrl-k` (or `ctrl-n` / `ctrl-p`) to move, `tab` /
`shift-tab` to (un)select several, `enter` to accept, `esc` / `ctrl-c` to quit.

## Integrations

`~/.config/zsh/32-fzf.zsh` -> `config/32-fzf.zsh` (each one only when the
tool is installed):

- [fd](../fd) as source: hidden files included, `.git` and
  `.gitignore`'d files excluded.
- [bat](../bat) preview of the highlighted file (`ctrl-t`, `**`).
- [eza](../eza) tree preview of the highlighted directory (`alt-c`, `cd **`).

Colors: the terminal's 16 ANSI colors (`--color=16` in `FZF_DEFAULT_OPTS`), so fzf
follows Ghostty's Catppuccin Latte / Mocha; bat previews use bat's `ansi` theme for
the same reason (inside fzf, bat can't ask the terminal for its background). Key
bindings come from the oh-my-zsh plugin instead of `fzf --zsh`.
