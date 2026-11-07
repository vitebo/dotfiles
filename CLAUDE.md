# CLAUDE.md

Personal dotfiles, inspired by [gnugat/dotfiles](https://github.com/gnugat/dotfiles)
but intentionally kept small. Read `README.md` for usage.

## Decisions

Keep this list up to date whenever a new decision is made.

- **Language**: everything in the repo (code, comments, messages, docs) is in English.
- **Own naming**: never use `ssdf` (gnugat's term). Our prefix is `dot`:
  functions `_dot_*`, variables `DOT_*`, internal package `00-core-dot`.
- **Small packages**: each tool is a self-contained `<NN>-<scope>-<name>/` folder with
  `install.sh`, optional `_apt.sh` / `_brew.sh`, `config/` and `README.md`.
  Package-specific helpers stay inside the package folder.
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
- **Devcontainers via the devcontainer CLI** (not an editor integration): don't
  mention any editor in docs. The repo may be cloned anywhere (eg `~/dotfiles`), so
  paths are always resolved relative to the script, never hardcoded.
- **Non-interactive and idempotent**: no prompts (no `cp -i`), safe to re-run.
  Config files are symlinked with `_dot_link` (existing regular files become `.bak`);
  lines are appended with `_dot_append_line` (no duplicates).
- **Portability**: bash scripts with `set -euo pipefail`; resolve dirs with
  `cd "$(dirname ...)" && pwd` instead of `readlink -f` / `realpath`.
- **Machine-specific config** goes in `~/.zshrc.local`, never in the repo.
- **Start minimal**: only homebrew (mac bootstrap), zsh and vim for now; no plugin
  managers or zsh plugins yet.
- **Commits**: Claude may commit as work progresses, without asking. Always follow
  [Conventional Commits](https://www.conventionalcommits.org) (`feat(zsh): ...`,
  `fix(core): ...`, `docs: ...`), scoped by package name when it applies, one logical
  change per commit.

## Adding a package

1. Create `<NN>-<scope>-<name>/` following an existing package (eg `20-any-vim`).
2. `install.sh`: resolve `DOT_PACKAGE_DIR` / `DOT_ROOT`, `source 00-core-dot/lib.sh`,
   `_dot_select_package_manager || true`, `_dot_install_with_package_manager`, `_dot_link`.
3. Add `_apt.sh` / `_brew.sh` as needed, a `README.md`, and a row in the root README table.

## Verifying

```sh
for f in install.sh */install.sh */_*.sh 00-core-dot/lib.sh 00-core-dot/functions/*.sh; do bash -n "$f"; done
bash install.sh && bash install.sh   # second run must not create .bak files or duplicate lines
zsh -i -c 'echo ok'
```
