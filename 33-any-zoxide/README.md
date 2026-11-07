# 33-any-zoxide

Installs [zoxide](https://github.com/ajeetdsouza/zoxide), a smarter `cd` that
learns the directories you visit.

## Usage

- `z dotfiles`: jump to the best match (eg `~/.dotfiles`), from anywhere
- `z dot nv`: several words narrow the match
- `zi`: pick interactively with fzf
- `cd` is unchanged (like gnugat), zoxide learns from it too

## Integrations

- oh-my-zsh's `zoxide` plugin ([22-any-oh-my-zsh](../22-any-oh-my-zsh)) runs
  `zoxide init`, enabled only when zoxide is installed.
- `zi` uses [32-any-fzf](../32-any-fzf) when installed.
- `~/.config/zsh/33-zoxide.zsh` -> `config/zoxide.zsh`: [31-any-eza](../31-any-eza)
  tree preview in `zi` (`_ZO_FZF_OPTS`, zoxide's default fzf options with only the
  preview changed), when fzf and eza are installed.
