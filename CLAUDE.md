# CLAUDE.md

Personal dotfiles, inspired by [gnugat/dotfiles](https://github.com/gnugat/dotfiles)
but intentionally kept small. Read `README.md` for usage.

## Decisions

Claude must update this list, in the same change, whenever a decision about how the
repo should behave is made (structure, conventions, tooling, workflow).

- **Language**: everything in the repo (code, comments, messages, docs) is in English.
- **Own naming**: never use `ssdf` (gnugat's term). Our prefix is `dot`:
  functions `_dot_*`, variables `DOT_*`, internal package `00-core-dot`.
- **Small packages**: each tool is a self-contained `<NN>-<scope>-<name>/` folder with
  `install.sh`, optional `_apt.sh` / `_brew.sh`, `config/` and `README.md`.
  Package-specific helpers stay inside the package folder.
- **One package per prerequisite**: every tool a package needs (eg nvchad needs
  neovim, git, build tools, unzip, ripgrep, tree-sitter, a nerd font) is its own
  package, even when it's a single apt line, so shared prerequisites stay reusable
  and explicit. A package never installs another package's tool:
  - the prerequisite gets a lower `NN` than its dependents (ordering is the only
    dependency mechanism, no automatic resolution);
  - the dependent checks them with `_dot_require <cmds>` and lists them, as links,
    under "Prerequisites" in its README.
  - Tools the OS already ships on one platform only get the other platform's script
    (eg `11-any-curl` has `_apt.sh` only, macOS ships curl).
  - A tool and its config are separate packages when the config is a project of its
    own (eg `17-any-neovim` installs nvim, `20-any-nvchad` is the config).
- **Folder prefix** `<NN>-<scope>-<name>`, replacing gnugat's numeric tags:
  - `NN`: global execution order (00–99), the shell glob sorts them.
  - `scope`: `core` (library, no `install.sh`), `any` (mac + linux), `mac`, `linux`.
  - Root `install.sh` runs `DOT_SCOPES="any <os>"` by default; overridable via env.
- **Platforms**: macOS (brew) and Linux devcontainers (apt, Debian/Ubuntu).
  - `_<pm>.sh` is sourced in a subshell (so `_dot_*` functions are available);
    a missing script means nothing to install for that package manager.
  - On mac, zsh has no `_brew.sh`: the system zsh is used (avoids `/etc/shells` changes).
  - `_dot_sudo` only uses `sudo` when not root (containers often run as root).
  - `chsh` to zsh only on linux; failure is a warning, not an error.
- **Linux is always a devcontainer**: GUI apps (brew casks, eg `19-mac-ghostty`,
  `18-mac-nerd-font`) and anything rendered by the host are `mac` scope only, with
  just a `_brew.sh`.
- **Versioned app config**: when a package configures an app, its config file lives in
  the package's `config/` and is symlinked to where the app reads it (eg
  `~/.config/ghostty/config.ghostty`, `~/.config/nvim`). Start from the app defaults.
- **Devcontainers via the devcontainer CLI** (not an editor integration): don't
  mention any editor in docs. The repo may be cloned anywhere (eg `~/dotfiles`), so
  paths are always resolved relative to the script, never hardcoded.
- **Non-interactive and idempotent**: no prompts (no `cp -i`), safe to re-run.
  Config files are symlinked with `_dot_link` (existing regular files become `.bak`);
  lines are appended with `_dot_append_line` (no duplicates).
- **Portability**: bash scripts with `set -euo pipefail`; resolve dirs with
  `cd "$(dirname ...)" && pwd` instead of `readlink -f` / `realpath`.
- **Machine-specific config** goes in `~/.zshrc.local`, never in the repo.
- **Start minimal**: only homebrew (mac bootstrap), zsh, NvChad and its prerequisites
  for now; no zsh plugins yet.
- **Editor is Neovim + NvChad** (`17-any-neovim` + `20-any-nvchad`), replacing vim:
  - The [NvChad starter](https://github.com/NvChad/starter) is vendored in
    `20-any-nvchad/config/nvim` (no `.git`, no starter README) and `~/.config/nvim`
    symlinks to it, so personal changes are versioned here. Plain NvChad for now.
  - `lazy-lock.json` is committed; install runs `nvim --headless "+Lazy! restore" +qa`
    so plugins match the lockfile. Update with `:Lazy sync` and commit the lockfile.
  - linux: apt's Neovim is too old (NvChad needs 0.11+) and tree-sitter isn't packaged,
    so both come from their GitHub releases (latest). mac: brew.
  - The nerd font is `mac` scope only: in a devcontainer the host terminal renders it.
- **Packages own their shell env**: a package may ship `config/<name>.zsh` and link it
  into `~/.config/zsh/`, which `~/.zshrc` loads (skipping dangling symlinks). Eg
  `EDITOR` lives in `17-any-neovim/config/neovim.zsh`, not in the zsh package.
- **Commits**: Claude may commit as work progresses, without asking. Always follow
  [Conventional Commits](https://www.conventionalcommits.org) (`feat(zsh): ...`,
  `fix(core): ...`, `docs: ...`), scoped by package name when it applies, one logical
  change per commit.

## Adding a package

1. Create a package for each missing prerequisite first (see "One package per prerequisite").
2. Create `<NN>-<scope>-<name>/` following an existing package (eg `15-any-ripgrep` for
   a tool, `20-any-nvchad` for a config), with `NN` above its prerequisites.
3. `install.sh`: resolve `DOT_PACKAGE_DIR` / `DOT_ROOT`, `source 00-core-dot/lib.sh`,
   then `_dot_require` (prerequisites), `_dot_select_package_manager || true` +
   `_dot_install_with_package_manager` (installs), `_dot_link` (config).
4. Add `_apt.sh` / `_brew.sh` as needed, a `README.md` (with "Prerequisites"), and a
   row in the root README table.

## Verifying

```sh
for f in install.sh */install.sh */_*.sh 00-core-dot/lib.sh 00-core-dot/functions/*.sh; do bash -n "$f"; done
bash install.sh && bash install.sh   # second run must not create .bak files or duplicate lines
zsh -i -c 'echo ok'
```
