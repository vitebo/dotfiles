# CLAUDE.md

Guidance for working in this repository. Keep changes aligned with the rules below.

## What this is

Framework-free dotfiles for macOS, Linux and Dev Containers. No Dotbot/Chezmoi/Stow.
Configuration is **data** (versioned files); automation is **code** (Bash in `lib/`).
Files reach the system only through symlinks — nothing in `$HOME` is edited in place.

## Commands

```sh
./install.sh            # full idempotent bootstrap (default when no task given)
./install.sh packages   # install core packages (git zsh curl) + neovim + uv
./install.sh symlinks   # link home/ -> ~/ and config/ -> ~/.config/
./install.sh secrets    # create ~/.config/dotfiles/secrets.zsh from the example
./install.sh ohmyzsh    # install Oh My Zsh (keeps existing .zshrc)
./install.sh doctor     # validate the environment, report inconsistencies
./install.sh help

bash -n install.sh lib/*.sh   # syntax check (always run after editing scripts)
shellcheck -x install.sh lib/*.sh   # lint (not installed by default: brew install shellcheck)
```

There is no test suite; validate with `bash -n`, `shellcheck`, and `./install.sh doctor`.

## Architecture (invariants — do not break)

- **`install.sh` is the only entry point.** It resolves the repo root, defines the
  global paths, loads modules, and dispatches tasks. It holds no business logic.
- **Only `install.sh` defines global paths:** `DOTFILES_ROOT`, `DOTFILES_LIB`,
  `DOTFILES_HOME`, `DOTFILES_CONFIG`. Modules must never recompute the root.
- **`lib/*.sh` are libraries: they only define functions and run no code when sourced.**
  No top-level `echo`, installs, or state. A new module must be added to the loop in
  `install.sh` (`_load_modules`) and, if user-facing, to the `case` + `usage`.
- **Modules never `source` each other.** They may call functions defined in sibling
  modules because `install.sh` has already sourced everything into the same shell
  (e.g. `packages.sh` calls `detect_os`, `doctor.sh` calls `_command_exists`).
- **Everything is idempotent.** Check current state before acting; re-running any task
  must be safe.
- **No absolute paths.** Derive everything from the globals / `$HOME`.
- **No state in the repo:** no cache, temp files, secrets, or generated artifacts
  (see `.gitignore`).

## Conventions

- Every script starts with `#!/usr/bin/env bash` and `set -Eeuo pipefail`.
- Public functions are unprefixed (`install_packages`, `create_symlinks`,
  `install_ohmyzsh`, `detect_os`); private helpers use a `_` prefix
  (`_install_homebrew`, `_symlink`).
- Logging goes through `common.sh` helpers (`log_info/success/warn/error/step`) — they
  print to stderr and respect `NO_COLOR`. Don't `echo` status directly.
- Use `_sudo` for privileged commands (no-op as root, `sudo` otherwise).
- Automation is Bash; Zsh is only the user's interactive shell.

## Symlinks

Generic, no hard-coded lists: every top-level entry of `home/` links into `$HOME/`,
every entry of `config/` into `$HOME/.config/`. Adding a file to the repo is enough for
it to sync. Existing real files are backed up to `*.backup.<timestamp>` before replacing;
correct existing symlinks are left untouched.

## Secrets

Never versioned. Live at `~/.config/dotfiles/secrets.zsh`, sourced by `.zshrc` only if
present. The repo ships `secrets.example.zsh` documenting expected variables.
Machine-specific git identity goes in `~/.config/dotfiles/gitconfig.local` (included by
`home/.gitconfig`; git ignores it silently when missing).

## Neovim / NvChad

`config/nvim/` is versioned NvChad config (installed once from the starter, `.git`
removed) — **treated as data, not automation; there is no install task for it.**
`create_symlinks` maps it to `~/.config/nvim`; lazy.nvim installs plugins on first launch.
Neovim is installed by `_install_neovim`, **not** from distro packages: apt/dnf ship
versions too old for NvChad (`init.lua` calls `vim.uv`, which needs Neovim >= 0.10; NvChad
wants >= 0.11). It prefers Homebrew, else downloads the official stable release into
`~/.local/nvim` and links it into `~/.local/bin`. The Mason toolchain also needs `uv`
(`_install_uv`: Homebrew, else Astral's installer, into `~/.local/bin`). `~/.local/bin` is
added to PATH by both `.zshrc` and `install.sh`. `doctor` verifies the Neovim version.
Override a NvChad plugin by adding a spec with a **table** `opts` in
`config/nvim/lua/plugins/init.lua` — lazy.nvim deep-merges it onto NvChad's defaults, so
you keep the inherited config. Do not use `config = function() ... setup() end`, which
replaces the defaults. Extract growing opts into `config/nvim/lua/configs/<plugin>.lua`
and reference with `opts = require "configs.<plugin>"` (organizational only; merge is
unchanged). `lazy-lock.json` is versioned for reproducible plugin versions.
