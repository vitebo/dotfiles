# Dotfiles

Simple, portable, framework-free dotfiles for macOS, Linux and Dev Containers.

Configuration is treated as **data** (plain files under version control) and
automation as **code** (Bash modules under `lib/`). Files are exposed to the
system through symlinks — nothing inside `$HOME` is edited directly.

## Quick start

```sh
git clone <this-repo> ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

Running `./install.sh` with no arguments performs a full, idempotent bootstrap.
Re-running it is always safe.

### Dev Containers

Point the `dotfiles` feature at this repository with `./install.sh` as the
install command. No absolute paths are used, so it works unchanged.

## Tasks

```sh
./install.sh            # full installation
./install.sh packages   # install required system packages
./install.sh symlinks   # link home/ -> ~/ and config/ -> ~/.config/
./install.sh secrets    # prepare ~/.config/dotfiles/secrets.zsh
./install.sh ohmyzsh    # install Oh My Zsh (keeps existing .zshrc)
./install.sh doctor     # validate the environment
./install.sh help       # usage
```

## Layout

```
dotfiles/
├── install.sh           # single entry point (Bash)
├── lib/                 # automation modules — functions only, no side effects
│   ├── common.sh        #   logging, colors, helpers
│   ├── os.sh            #   OS / package-manager detection
│   ├── packages.sh      #   package installation
│   ├── symlinks.sh      #   generic symlink creation
│   ├── ohmyzsh.sh       #   Oh My Zsh installation
│   ├── secrets.sh       #   local secrets management
│   └── doctor.sh        #   environment diagnostics
├── home/                # linked into $HOME/         (e.g. .zshrc, .gitconfig)
├── config/              # linked into $HOME/.config/  (e.g. nvim/ — NvChad)
├── scripts/             # standalone helper scripts
├── secrets.example.zsh  # documents expected secret variables
├── README.md
└── .gitignore
```

## How it works

- **Symlinks are generic.** Every top-level entry of `home/` is linked into
  `$HOME/`, and every entry of `config/` into `$HOME/.config/`. Adding a new
  file to the repo is all it takes — there are no hard-coded lists. Existing
  real files are backed up (`*.backup.<timestamp>`) before being replaced.
- **Only the entry point knows paths.** `install.sh` computes `DOTFILES_ROOT`,
  `DOTFILES_LIB`, `DOTFILES_HOME` and `DOTFILES_CONFIG` and loads the modules.
  Modules never source each other and never recompute the root.
- **Secrets are never versioned.** They live at
  `~/.config/dotfiles/secrets.zsh` and are sourced by `.zshrc` only when
  present. The repo ships only `secrets.example.zsh`. Machine-specific git
  settings go in `~/.config/dotfiles/gitconfig.local`.
- **Neovim / NvChad is versioned config, not automation.** The NvChad starter
  was installed once (per the [official docs](https://nvchad.com/docs/quickstart/install)),
  its `.git` removed, and the generated files committed under `config/nvim`.
  `create_symlinks` links it to `~/.config/nvim`; on first `nvim` launch,
  lazy.nvim installs the plugins. Update with `:Lazy sync` from inside Neovim.

## Conventions

- Scripts start with `#!/usr/bin/env bash` and `set -Eeuo pipefail`.
- Public functions: `install_packages`, `create_symlinks`, `install_ohmyzsh`,
  `detect_os`, ... Private helpers are prefixed with `_`.
- All code aims to be idempotent, single-responsibility and ShellCheck-clean.
