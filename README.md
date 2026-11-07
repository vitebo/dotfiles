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
| [10-any-zsh](10-any-zsh/README.md) | zsh: history, completion, aliases, prompt |
| [11-any-curl](11-any-curl/README.md) | curl |
| [12-any-git](12-any-git/README.md) | git |
| [13-any-build-tools](13-any-build-tools/README.md) | C compiler and make |
| [14-any-unzip](14-any-unzip/README.md) | unzip |
| [15-any-ripgrep](15-any-ripgrep/README.md) | ripgrep (`rg`) |
| [16-any-tree-sitter](16-any-tree-sitter/README.md) | tree-sitter CLI |
| [17-any-neovim](17-any-neovim/README.md) | Neovim, as the default editor |
| [18-mac-nerd-font](18-mac-nerd-font/README.md) | JetBrainsMono Nerd Font |
| [20-any-nvchad](20-any-nvchad/README.md) | NvChad config for Neovim (versioned in the repo) |

## Local config

Machine specific tweaks live out of the repo, in `~/.zshrc.local`.
