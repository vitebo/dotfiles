# CLAUDE.md

Personal dotfiles, inspired by [gnugat/dotfiles](https://github.com/gnugat/dotfiles)
but intentionally kept small. Read `README.md` for usage.

## Decisions

Claude must update this list, in the same change, whenever a decision about how the
repo should behave is made (structure, conventions, tooling, workflow).

- **Compare with gnugat first**: before deciding how to handle something new, look at
  how [gnugat/dotfiles](https://github.com/gnugat/dotfiles/tree/main) does it, then
  follow it or record here why we diverge.
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
  - Tools that Debian/Ubuntu install under another name (`batcat`, `fdfind`) get an
    alias back to their usual name in the package's zsh snippet, so commands are the
    same on mac and linux.
- **Linux is always a devcontainer**: GUI apps (brew casks, eg `19-mac-ghostty`,
  `18-mac-nerd-font`) and anything rendered by the host are `mac` scope only, with
  just a `_brew.sh`.
- **Versioned app config**: when a package configures an app, its config file lives in
  the package's `config/` and is symlinked to where the app reads it (eg
  `~/.config/ghostty/config.ghostty`, `~/.config/nvim`). Start from the app defaults:
  when the app ships a default config file, copy it as is and mark each of our
  changes with a `dotfiles:` comment explaining why (eg `23-mac-aerospace`).
  Exception: files the app rewrites itself (eg gh's `config.yml`, Claude Code's
  `settings.json`) stay exactly as the app writes them, since it drops our comments;
  their explanation goes in the package README.
- **Per-machine logins**: CLI tools with an account (gh, Claude Code) keep their login
  out of the repo (`hosts.yml`, `~/.claude.json`, keychain); each machine logs in with
  its own account, so personal and work machines share the same config.
- **AeroSpace owns `alt` + `h/j/k/l`**: it grabs them globally, so terminal tools
  can't use them (eg tmux panes are `prefix + h/j/k/l`, unlike gnugat's `alt`).
- **AeroSpace manages windows, apps don't tab**: apps with macOS native tabs (eg
  Ghostty) are configured to open windows instead, since native tabs are separate
  windows that AeroSpace tiles one by one; AeroSpace's accordion layout plays the tab
  role, like i3's tabbed layout.
- **AeroSpace + SketchyBar**: SketchyBar replaces the macOS menu bar (hidden by hand
  in System Settings) and shows AeroSpace workspaces, following AeroSpace's official
  integration. AeroSpace starts it (`after-startup-command`) instead of
  `brew services` like gnugat, so there's no LaunchAgent written in `~/Library`.
  The glue lives in `aerospace.toml` (one file can't be split across packages), so
  `24-mac-sketchybar` requires `aerospace` and the AeroSpace config mentions it.
  - Same pattern for JankyBorders (`25-mac-jankyborders`), which highlights the
    focused window (gnugat has no focus indicator; AeroSpace's goodies recommend it):
    started by AeroSpace, configured by a versioned `bordersrc`.
  - AeroSpace's service mode `esc` reloads AeroSpace and every tool it starts.
- **Ask before integrating packages**: when a new package can integrate with packages
  already in the repo (eg fzf using fd as source and bat/eza for previews, delta as
  git's pager), Claude lists each possible integration, explains how it would work,
  and asks which ones to add before implementing them. Never wire integrations in
  silently, even when gnugat does.
- **Plugging into another package's config**: when a tool configures another one
  (eg delta in git), it ships its own linked file and the host config includes it
  with a mechanism that ignores missing files (git `[include]`), like gnugat; so the
  host package keeps working where the tool isn't installed. The include line lives
  in the host config with a comment naming the package.
- **Third-party brew taps**: when a tool isn't in the official casks/formulae,
  `_brew.sh` runs `brew tap` + `brew trust` + `brew install` from that tap, like
  gnugat (eg `nikitabobko/tap/aerospace`).
- **`$HOME` only holds symlinks into the repo**: installers never append to or edit
  files in `$HOME`; any config file we care about is versioned and linked. Prefer the
  XDG location (`~/.config/<app>/`) when the app supports it, like gnugat (eg git uses
  `~/.config/git/config`, so `~/.gitconfig` must not exist). State files (shell
  history, `.zcompdump`, caches) are not versioned and stay where the tool puts them.
- **Migrations**: when a change moves or renames a linked file, installers don't delete
  the old one (they never remove user files); Claude cleans the stale files on this
  machine by hand, after checking their content is now in the repo.
- **Devcontainers via the devcontainer CLI** (not an editor integration): don't
  mention any editor in docs. The repo may be cloned anywhere (eg `~/dotfiles`), so
  paths are always resolved relative to the script, never hardcoded.
- **Non-interactive and idempotent**: no prompts (no `cp -i`), safe to re-run.
  Config files are symlinked with `_dot_link` (existing regular files become `.bak`).
- **Portability**: bash scripts with `set -euo pipefail`; resolve dirs with
  `cd "$(dirname ...)" && pwd` instead of `readlink -f` / `realpath`.
- **Machine-specific config** goes in `~/.zshrc.local`, never in the repo.
- **Start minimal**: only homebrew (mac bootstrap), zsh + oh-my-zsh, NvChad and its
  prerequisites, Ghostty, Claude Code, AeroSpace, SketchyBar, JankyBorders, tree,
  fastfetch, bat, delta, fd, eza, fzf, zoxide, tmux, gh and jq for now; oh-my-zsh
  with its defaults.
- **Themes**: no color theme yet (gnugat uses Catppuccin everywhere); tools keep their
  default theme until we pick one for all of them. Where we style our own UI, we use
  the same neutral palette: light `#e2e2e3` on `#414550` for the active item
  (JankyBorders' colors), grays for the others (eg tmux's status line, whose colors
  live in `@dot_*` options so a future theme changes them in one place).
- **Frameworks: external code, versioned config**: for a framework (NvChad,
  oh-my-zsh), the framework itself is installed outside the repo (plugin manager,
  `~/.local/share/<name>`) and only our config of it is versioned, so personal
  changes are tracked without vendoring the framework.
- **Shell: zsh + oh-my-zsh** (diverges from gnugat, which sets up zsh by hand with
  setopt/compinit and uses starship):
  - `10-any-zsh` is only the shell and its loader (`~/.zshrc`, `chsh`).
  - `22-any-oh-my-zsh` owns the shell setup: theme/prompt, plugins, completion
    (`compinit`), history options, key bindings, common aliases. Don't re-set those
    elsewhere. It's cloned (not the official installer, which replaces `~/.zshrc`)
    into `~/.local/share/oh-my-zsh`; its config is the `oh-my-zsh.zsh` snippet.
  - A tool's oh-my-zsh plugin (eg `fzf`, `zoxide`, `tmux`) is enabled in `oh-my-zsh.zsh` only when the
    tool is installed (`(( $+commands[fzf] ))`), since plugins may error out without
    it; the tool's package keeps its own settings (eg fzf's integrations) in its
    snippet.
  - Functions in package snippets call tools with `command <tool>` when oh-my-zsh
    aliases that tool (eg `tmux`): aliases expand when the function is defined.
  - Our own aliases/options go in package snippets (no `$ZSH_CUSTOM`). Packages that
    extend `fpath` need a lower `NN` than oh-my-zsh, which runs `compinit`.
  - A tool package may deliberately replace an oh-my-zsh alias from its snippet: it
    needs a higher `NN` than oh-my-zsh (loaded after it), defines it only when the
    tool is installed, and says so in its README (eg `31-any-eza` replaces `l` /
    `la` / `ll`).
  - One owner per alias: never define the same alias in two packages relying on
    `NN` order to pick one (gnugat defines `l` / `ll`... in both tree and eza; here
    only eza does).
- **Editor is Neovim + NvChad** (`17-any-neovim` + `20-any-nvchad`), replacing vim:
  - The [NvChad starter](https://github.com/NvChad/starter) is vendored in
    `20-any-nvchad/config/nvim` (no `.git`, no starter README) and `~/.config/nvim`
    symlinks to it, so personal changes are versioned here. Plain NvChad for now.
  - `lazy-lock.json` is committed; install runs `nvim --headless "+Lazy! restore" +qa`
    so plugins match the lockfile. Update with `:Lazy sync` and commit the lockfile.
  - linux: apt's Neovim is too old (NvChad needs 0.11+) and tree-sitter isn't packaged,
    so both come from their GitHub releases (latest). mac: brew.
  - The nerd font is `mac` scope only: in a devcontainer the host terminal renders it.
- **Same dotfiles on personal and work machines**: the repo holds one shared config;
  never version per-machine or per-account variants (no profiles), so nothing from
  the company ends up in this repo. Per-machine differences live out of the repo:
  credentials stay where the tool keeps them, env vars go in `~/.zshrc.local`, extra
  files sit next to the linked ones, and org policy comes from the org's own tooling.
  This is why config dirs that mix shared files and machine files (eg `~/.claude`)
  are linked file by file, never as a whole directory.
- **Claude Code** (`21-any-claude-code`): native installer (`curl … | bash`, like
  gnugat) on mac and linux, so it auto-updates; `~/.local/bin` is put in PATH by its
  zsh snippet (the installer itself doesn't edit rc files).
  - Versioned: `~/.claude/settings.json`, `~/.claude/CLAUDE.md` (personal
    instructions for every project) and `~/.claude/rules/*.md` (one topic per file;
    use `paths` frontmatter for rules that only matter for some files). Keep them
    short, simple and valid on both machines; anything project-specific belongs in
    that project's own `CLAUDE.md`.
  - Claude runs on the host; `rules/devcontainer.md` makes it run project commands
    inside the project's devcontainer (devcontainer CLI) when there is one.
  - Not versioned: `~/.claude.json` + keychain (account), sessions, history, caches.
  - Work-only: managed settings from the org, plain files in `~/.claude/rules/`,
    env vars in `~/.zshrc.local`.
  - Claude Code rewrites `settings.json` (`/config`, `/model`); review those diffs:
    commit if shared, otherwise revert and set locally.
- **Packages own their shell env**: a package may ship `config/<name>.zsh` and link it
  with `_dot_link_zsh` to `~/.config/zsh/<NN>-<name>.zsh`; `~/.zshrc` loads them in
  package order (skipping dangling symlinks). Eg `EDITOR` lives in
  `17-any-neovim/config/neovim.zsh`, brew's env in `01-mac-homebrew/config/homebrew.zsh`.
  - Only `~/.zshrc` is used: no `~/.zprofile` / `~/.zshenv` (gnugat also sets PATH
    from the rc). Interactive shells are the target.
  - `compinit` is run by oh-my-zsh, from its snippet (see "Shell: zsh + oh-my-zsh").
  - A snippet that prints something at startup (eg `27-mac-fastfetch`) only does it
    when stdout is a terminal (`[[ -t 1 ]]`), so scripts and tools spawning a shell
    get no extra output.
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
   `_dot_install_with_package_manager` (installs), `_dot_link` / `_dot_link_zsh` (config).
4. Add `_apt.sh` / `_brew.sh` as needed, a `README.md` (with "Prerequisites"), and a
   row in the root README table.

## Verifying

```sh
for f in install.sh */install.sh */_*.sh 00-core-dot/lib.sh 00-core-dot/functions/*.sh; do bash -n "$f"; done
bash install.sh && bash install.sh   # second run must not create .bak files or duplicate lines
zsh -i -c 'echo ok'
```
