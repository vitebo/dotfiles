# dotfiles

Shell and tooling configuration, organized in small, self-contained packages.
Works on **macOS** (brew) and **Linux / devcontainers** (apt).

Inspired by [gnugat/dotfiles](https://github.com/gnugat/dotfiles).

## Installation

```sh
git clone <repo> ~/.dotfiles && bash ~/.dotfiles/install.sh
```

Scripts are idempotent: they can be run as many times as needed.

### Devcontainers

With the [devcontainer CLI](https://github.com/devcontainers/cli), pass this
repository when starting the container; it gets cloned and its `install.sh` runs:

```sh
devcontainer up --workspace-folder . --dotfiles-repository <repo>
```

Nothing depends on the `~/.dotfiles` path, and the installation never prompts.

## Structure

```
.
├── <NN>-<scope>-<name>/
│   ├── install.sh     # installs the package and creates the symlinks
│   ├── _apt.sh        # (optional) install with apt
│   ├── _brew.sh       # (optional) install with brew
│   ├── config/        # config files (symlinked into $HOME)
│   └── README.md
└── install.sh         # runs the packages in order
```

- `NN`: execution order (00–99). Prerequisites are packages too, with a lower `NN`
  than the packages that need them.
- `scope`: where the package runs.
  - `core`: internal functions (`_dot_*`), nothing to install — see [00-core-dot](00-core-dot/README.md)
  - `any`: mac and linux
  - `mac`: macOS only
  - `linux`: linux only

The root `install.sh` detects the OS and runs the `any` + `mac` or `any` + `linux` scopes.
To choose manually:

```sh
DOT_SCOPES="any" bash install.sh        # cross-platform packages only
bash 15-any-ripgrep/install.sh          # a single package (its prerequisites must be installed)
DOT_PM=brew bash install.sh             # force a package manager
```

## Packages

| Package | Description |
| --- | --- |
| [01-mac-homebrew](01-mac-homebrew/README.md) | Homebrew |
| [10-any-zsh](10-any-zsh/README.md) | zsh and its `~/.zshrc` loader |
| [11-any-curl](11-any-curl/README.md) | curl |
| [12-any-git](12-any-git/README.md) | git |
| [13-any-build-tools](13-any-build-tools/README.md) | C compiler and make |
| [14-any-unzip](14-any-unzip/README.md) | unzip |
| [15-any-ripgrep](15-any-ripgrep/README.md) | ripgrep (`rg`) |
| [16-any-tree-sitter](16-any-tree-sitter/README.md) | tree-sitter CLI |
| [17-any-neovim](17-any-neovim/README.md) | Neovim, as the default editor |
| [18-mac-nerd-font](18-mac-nerd-font/README.md) | JetBrainsMono Nerd Font |
| [19-mac-ghostty](19-mac-ghostty/README.md) | Ghostty terminal (config versioned in the repo) |
| [20-any-nvchad](20-any-nvchad/README.md) | NvChad config for Neovim (versioned in the repo) |
| [21-any-claude-code](21-any-claude-code/README.md) | Claude Code, with config shared across machines |
| [22-any-oh-my-zsh](22-any-oh-my-zsh/README.md) | oh-my-zsh: prompt, plugins, completion, history (config versioned in the repo) |
| [23-mac-aerospace](23-mac-aerospace/README.md) | AeroSpace tiling window manager (config versioned in the repo) |
| [24-mac-sketchybar](24-mac-sketchybar/README.md) | SketchyBar status bar, with AeroSpace workspaces |
| [25-mac-jankyborders](25-mac-jankyborders/README.md) | JankyBorders: border around the focused window |
| [26-any-tree](26-any-tree/README.md) | tree, directory listing as a tree |
| [27-mac-fastfetch](27-mac-fastfetch/README.md) | fastfetch system summary, shown when a terminal opens |
| [28-any-bat](28-any-bat/README.md) | bat (`cat` with syntax highlighting), also for man pages |
| [29-any-git-delta](29-any-git-delta/README.md) | delta, syntax-highlighting pager for git |
| [30-any-fd](30-any-fd/README.md) | fd, a fast alternative to `find` |
| [31-any-eza](31-any-eza/README.md) | eza, a modern `ls`, used by the `l` / `la` / `ll` / `lla` aliases |
| [32-any-fzf](32-any-fzf/README.md) | fzf fuzzy finder: history, files, `cd`, `**` completion |
| [33-any-zoxide](33-any-zoxide/README.md) | zoxide, a smarter `cd` (`z`, `zi`) |
| [34-any-tmux](34-any-tmux/README.md) | tmux terminal multiplexer, with `tz` (zoxide sessions) |
| [35-any-gh](35-any-gh/README.md) | GitHub CLI, also git's credentials for github.com |

## Local config

Machine specific tweaks live out of the repo, in `~/.zshrc.local`.
