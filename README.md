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

- `NN`: execution order (00–99).
- `scope`: where the package runs.
  - `core`: internal functions (`_dot_*`), nothing to install — see [00-core-dot](00-core-dot/README.md)
  - `any`: mac and linux
  - `mac`: macOS only
  - `linux`: linux only

The root `install.sh` detects the OS and runs the `any` + `mac` or `any` + `linux` scopes.
To choose manually:

```sh
DOT_SCOPES="any" bash install.sh        # cross-platform packages only
bash 20-any-nvim/install.sh             # a single package
DOT_PM=brew bash install.sh             # force a package manager
```

## Packages

| Package | Description |
| --- | --- |
| [01-mac-homebrew](01-mac-homebrew/README.md) | Homebrew |
| [10-any-zsh](10-any-zsh/README.md) | zsh: history, completion, aliases, prompt |
| [20-any-nvim](20-any-nvim/README.md) | Neovim with NvChad (config versioned in the repo) |

## Local config

Machine specific tweaks live out of the repo, in `~/.zshrc.local`.
