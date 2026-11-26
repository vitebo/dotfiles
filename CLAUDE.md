# CLAUDE.md

Personal dotfiles, intentionally kept small. Read `README.md` for usage.

## Decisions

Claude must update this list, in the same change, whenever a decision about how the
repo should behave is made (structure, conventions, tooling, workflow).

- **Initial inspiration credited once**: only the root `README.md` names the dotfiles
  this repo started from; it has diverged since. Code, comments and docs explain
  decisions on their own, without comparing to it.
- **Language**: everything in the repo (code, comments, messages, docs) is in English.
- **Own naming**: our prefix is `dot`: functions `_dot_*`, variables `DOT_*`,
  internal library `core/`.
- **Small packages**: each tool is a self-contained `packages/<name>/` folder with
  `install.sh`, `uninstall.sh`, optional `_apt.sh` / `_brew.sh` (and their
  `_apt_uninstall.sh` / `_brew_uninstall.sh`), `config/` and `README.md`.
  Package-specific helpers stay inside the package folder.
- **Every package can be uninstalled**: every package has an `uninstall.sh` that
  undoes everything its `install.sh` did, in reverse order; `_dot_profile_packages`
  refuses a package without one. Any change to an `install.sh` updates its
  `uninstall.sh` in the same change.
  - It removes what the install created: the tool (brew / apt / release binary),
    every symlink (`_dot_unlink` / `_dot_unlink_zsh` for each `_dot_link` /
    `_dot_link_zsh`, restoring a `.bak` and removing the dirs left empty), clones and
    plugins, mise tools, registrations (MCP servers, git config).
  - User state stays: shell history, logins (`hosts.yml`, `~/.claude.json`,
    `~/.aws`), sessions, app data (casks are uninstalled without `--zap`), Docker
    images. Reinstalling gets back to the same point, logins included.
  - Idempotent like the install: nothing to remove is a no-op; it never fails
    because its prerequisites are already gone (guard with `command -v`).
  - `bash uninstall.sh <profile>` runs a profile's `uninstall.sh` in reverse order.
    `homebrew`'s removes Homebrew itself, with everything brew installed.
- **Device profiles**: each device has a profile, `profiles/<name>` (`work`: work
  MacBook, `notebook`: personal MacBook, `studio`: iMac, `devcontainer`): the list
  of its packages, in install order (one per line, `#` comments). Only devices are
  profiles; shared lists are presets, `presets/<name>`, reused with
  `preset <name>` (`base`: cross-platform, every device; `mac`: every mac, uses
  `base`). A preset can use another preset, a profile never uses a profile; a
  package listed twice is installed once. `core/functions/_dot_profile_packages.sh`
  resolves them.
  - `bash install.sh <profile>`: required on mac; on linux it defaults to
    `devcontainer`, since the devcontainer CLI runs `install.sh` without arguments.
  - `set DOT_<NAME>=<value>` in a profile is a value that differs per device because
    of its hardware (eg `profiles/studio`: no notch, so a different AeroSpace top gap).
    `install.sh` exports them (a later `set` wins, so a device overrides its
    presets) and saves the profile name in `~/.local/state/dotfiles/profile` (state,
    removed by `uninstall.sh`), so a package re-rendering its config later uses the
    same values (`_dot_profile_export_saved`); the package has the default. Never for accounts or
    company data (see "Same dotfiles on personal and work machines").
  - A device-only package goes in that device's profile (eg Slack, the AWS CLI and
    kubectl only in `work`); a package every mac needs goes in `mac`.
  - Folder names carry no order or platform: install order is the profile's, shell
    load order is the zsh snippet's `NN` (see "Packages own their shell env"), and
    platform is which profiles include it (plus which `_<pm>.sh` it has).
- **One package per prerequisite**: every tool a package needs (eg nvchad needs
  neovim, git, build tools, unzip, ripgrep, tree-sitter, a nerd font) is its own
  package, even when it's a single apt line, so shared prerequisites stay reusable
  and explicit. A package never installs another package's tool:
  - the prerequisite comes before its dependents in every profile that has them
    (profile order is the only dependency mechanism, no automatic resolution);
  - the dependent checks them with `_dot_require <cmds>` and lists them, as links,
    under "Prerequisites" in its README.
  - Tools the OS already ships on one platform only get the other platform's script
    (eg `curl` has `_apt.sh` only, macOS ships curl).
  - A tool and its config are separate packages when the config is a project of its
    own (eg `neovim` installs nvim, `nvchad` is the config).
- **Platforms**: macOS (brew) and Linux devcontainers (apt, Debian/Ubuntu).
  - `_<pm>.sh` is sourced in a subshell (so `_dot_*` functions are available);
    a missing script means nothing to install for that package manager.
  - On mac, zsh has no `_brew.sh`: the system zsh is used (avoids `/etc/shells` changes).
  - `_dot_sudo` only uses `sudo` when not root (containers often run as root).
  - `chsh` to zsh only on linux; failure is a warning, not an error.
  - Tools that Debian/Ubuntu install under another name (`batcat`, `fdfind`) get an
    alias back to their usual name in the package's zsh snippet, so commands are the
    same on mac and linux.
- **Linux is always a devcontainer**: GUI apps (brew casks, eg `ghostty`,
  `nerd-font`) and anything rendered by the host are only in mac profiles, with
  just a `_brew.sh`.
- **Versioned app config**: when a package configures an app, its config file lives in
  the package's `config/` and is symlinked to where the app reads it (eg
  `~/.config/ghostty/config.ghostty`, `~/.config/nvim`). Start from the app defaults:
  when the app ships a default config file, copy it as is and mark each of our
  changes with a `dotfiles:` comment explaining why (eg `aerospace`). When the
  app only prints a full dump of its defaults (eg `lazygit --config`), start from a
  minimal file instead (header + link to the docs + our changes): copying the dump
  would freeze today's defaults.
  Exception: files the app rewrites itself (eg gh's `config.yml`, Claude Code's
  `settings.json`) stay exactly as the app writes them, since it drops our comments;
  their explanation goes in the package README.
- **Per-machine logins**: CLI tools with an account (gh, Claude Code, docker, aws) keep
  their login out of the repo (`hosts.yml`, `~/.claude.json`, `~/.docker/config.json`,
  `~/.aws/`, keychain); each machine logs in with its own account, so personal and work machines
  share the same config. Files mixing app-managed state and logins (eg
  `~/.docker/config.json`) aren't versioned at all.
- **AeroSpace owns `alt` + `h/j/k/l`**: it grabs them globally, so terminal tools
  can't use them (eg tmux panes are `prefix + h/j/k/l`).
- **AeroSpace is the only hotkey daemon**: no skhd (a second daemon would compete for
  the same keys). Hotkeys to launch apps or run commands go in `aerospace.toml`
  (`exec-and-forget`), never on `alt` + letter (it types characters like `ç`).
  `alt-enter` opens a new Ghostty window (Ghostty's AppleScript `new window`).
  Planned, not done yet: `ctrl-alt-<letter>` to open apps; work-only hotkeys stay
  out of the repo.
- **Apps pinned to AeroSpace workspaces**: an app package that wants a fixed
  workspace adds an `[[on-window-detected]]` rule (by app id) at the end of
  `aerospace.toml`, with a comment naming the package (eg Slack on 9).
- **AeroSpace manages windows, apps don't tab**: apps with macOS native tabs (eg
  Ghostty) are configured to open windows instead, since native tabs are separate
  windows that AeroSpace tiles one by one; AeroSpace's accordion layout plays the tab
  role, like i3's tabbed layout.
- **AeroSpace + SketchyBar**: SketchyBar replaces the macOS menu bar (hidden by hand
  in System Settings) and shows AeroSpace workspaces, following AeroSpace's official
  integration. AeroSpace starts it (`after-startup-command`) instead of
  `brew services`, so there's no LaunchAgent written in `~/Library`.
  The glue lives in `aerospace.toml` (one file can't be split across packages), so
  `sketchybar` requires `aerospace` and the AeroSpace config mentions it.
  - Same pattern for JankyBorders (`jankyborders`), which highlights the
    focused window (AeroSpace's goodies recommend it): started by AeroSpace,
    configured by a versioned `bordersrc`.
  - AeroSpace's service mode `esc` reloads AeroSpace and every tool it starts.
- **Challenge packages that don't fit**: before adding a package, Claude checks it
  makes sense for this repo (mac host + linux devcontainers, existing packages,
  decisions here) and, when it may not, says so and explains why, suggesting an
  alternative if there is one, instead of adding it. Eg xclip: X11
  clipboard for a Linux desktop, useless in a devcontainer (no display); tmux's OSC 52
  clipboard already covers it.
- **Ask before integrating packages**: when a new package can integrate with packages
  already in the repo (eg fzf using fd as source and bat/eza for previews, delta as
  git's pager), Claude lists each possible integration, explains how it would work,
  and asks which ones to add before implementing them. Never wire integrations in
  silently.
- **Plugging into another package's config**: when a tool configures another one
  (eg delta in git), it ships its own linked file and the host config includes it
  with a mechanism that ignores missing files (git `[include]`), so the
  host package keeps working where the tool isn't installed. When the host has no
  such include, its snippet adds the file only when the tool exists (eg lazygit's
  `LG_CONFIG_FILE` merges `delta.yml` when delta is installed). The include line lives
  in the host config with a comment naming the package.
- **Third-party brew taps**: when a tool isn't in the official casks/formulae,
  `_brew.sh` runs `brew tap` + `brew trust` + `brew install` from that tap (eg
  `nikitabobko/tap/aerospace`).
- **`XDG_CONFIG_HOME=~/.config`** is exported by `zsh` (`10-xdg.zsh`),
  so XDG tools (lazygit, lazydocker, k9s...) use `~/.config` on macOS instead of
  `~/Library/Application Support`. Only the config dir: data / cache / state stay
  where each tool puts them.
- **`$HOME` only holds symlinks into the repo**: installers never append to or edit
  files in `$HOME`; any config file we care about is versioned and linked. Prefer the
  XDG location (`~/.config/<app>/`) when the app supports it (eg git uses
  `~/.config/git/config`, so `~/.gitconfig` must not exist). State files (shell
  history, `.zcompdump`, caches) are not versioned and stay where the tool puts them.
  - Exception: a config with per-device values (profile `set`) whose app can't
    include another file is rendered from the versioned template with `_dot_render`
    (`@DOT_<NAME>@` placeholders) instead of linked, and removed with
    `_dot_unrender` (eg `aerospace.toml`). Prefer an include when the app has one.
    The package's `render.sh` re-renders it, hooked to the app's own reload when it
    has one (AeroSpace's service mode `esc`), so editing the template doesn't need
    a reinstall.
- **Migrations**: when a change moves or renames a linked file, installers don't delete
  the old one (they never remove user files); Claude cleans the stale files on this
  machine by hand, after checking their content is now in the repo.
- **Devcontainers via the devcontainer CLI** (not an editor integration): don't
  mention any editor in docs. The CLI is its own package (`devcontainer`, a
  mise npm tool), not part of Docker's, so devcontainer helper scripts go there.
  The repo may be cloned anywhere (eg `~/dotfiles`), so paths are always resolved
  relative to the script, never hardcoded.
- **Non-interactive and idempotent**: no prompts (no `cp -i`), safe to re-run.
  Config files are symlinked with `_dot_link` (existing regular files become `.bak`).
- **Portability**: bash scripts with `set -euo pipefail`; resolve dirs with
  `cd "$(dirname ...)" && pwd` instead of `readlink -f` / `realpath`.
- **Machine-specific config** goes in `~/.zshrc.local`, never in the repo.
- **System preferences are set by hand**: installers don't change macOS preferences
  (default browser, menu bar, Mission Control...), which may need confirmation
  dialogs or a logout; the steps are documented in the package README
  (eg Chrome as default browser in `google-chrome`).
- **Start minimal**: only homebrew (mac bootstrap), zsh + oh-my-zsh, NvChad and its
  prerequisites, Ghostty, Claude Code, AeroSpace, SketchyBar, JankyBorders, tree,
  fastfetch, bat, delta, fd, eza, fzf, zoxide, tmux, gh, jq, Docker Desktop, Slack,
  the AWS CLI, mise (Node.js 22), lazygit, lazydocker, k9s, kubectl, Helm, Chrome,
  AWS Client VPN, Chrome DevTools MCP, Grafana MCP, cloudflared, NordPass, chafa,
  btop, a Catppuccin wallpaper and the Dev Containers CLI for now; oh-my-zsh with its
  defaults.
- **Project tools stay in the project's devcontainer**: tools a project needs at work
  (eg the AWS CLI, runtimes managed by mise) are only in mac profiles here; inside devcontainers each project installs
  them from its own `devcontainer.json`, with its own credentials.
- **Runtimes via mise**: language runtimes on the mac (eg Node.js 22, the global
  `node`) are declared in mise's versioned global config (`mise`) and
  installed by its `install.sh`; never through brew (`brew install node`).
  - CLIs distributed through npm (eg the Dev Containers CLI) are mise tools too (`npm:<package>`),
    never `npm install -g` (lost on Node.js upgrades): their package links its own
    `~/.config/mise/conf.d/<name>.toml` and runs `mise install`, without editing
    mise's package.
- **Docker**: Docker Desktop on every mac (`docker`), the same runtime on
  each, not inside devcontainers.
- **Kubernetes**: the local cluster is Docker Desktop's built-in one (enabled in its
  settings), no kind / minikube. kubectl is its own brew package (`kubectl`),
  not the one Docker Desktop ships; kubeconfig and Helm repos stay per machine.
- **Themes: Catppuccin, following the macOS appearance**: Latte in light mode,
  Mocha in dark mode, switching live when macOS switches. Tools without a
  Catppuccin option (eg Claude Code) use their own light / dark theme, switched
  with the mode.
  - Ghostty follows macOS natively (`theme = light:…,dark:…`) and is the source of
    truth for everything running in a terminal, on the host and in devcontainers
    (their TUIs render in the same Ghostty, so nothing in a container reads macOS).
  - Terminal tools get the mode from the terminal, never from macOS: use the 16
    ANSI colors when the tool allows it (they change with Ghostty's palette), else
    the tool's light / dark detection, else a light and a dark palette switched on
    the terminal's report (eg tmux's `light-theme-*` / `dark-theme-*` colours).
    Detection is either a query of the background color (OSC 11, read once at
    start) or a notification on each change (mode 2031, live); multiplexers (tmux)
    must pass both through to the apps inside them.
  - Only host GUI tools (SketchyBar, JankyBorders) listen to macOS directly.
  - The wallpaper (`wallpaper`) is one Mocha image in both modes (a dynamic
    HEIC built by hand wasn't recognized by macOS, so it was dropped for
    simplicity); it's set by hand once, like other system preferences. It's a
    free-licensed photo recolored with lutgen, credited in the package README.
  - Colors we set by hand come from the official Catppuccin palettes and live in one
    place per tool (eg tmux's `@dot_*` options, SketchyBar's `colors.sh`).
- **Frameworks: external code, versioned config**: for a framework (NvChad,
  oh-my-zsh), the framework itself is installed outside the repo (plugin manager,
  `~/.local/share/<name>`) and only our config of it is versioned, so personal
  changes are tracked without vendoring the framework.
  - tmux plugins go through TPM, the same way: `tmux`'s `install.sh` clones
    each `@plugin` listed in `tmux.conf` into `~/.local/share/tmux/plugins` (not
    TPM's `install_plugins`, which needs a running tmux server with this config).
    Today: tmux-resurrect + tmux-continuum, so sessions survive a reboot.
- **Shell: zsh + oh-my-zsh** (rather than setting up zsh by hand with
  setopt/compinit, or starship):
  - `zsh` is only the shell and its loader (`~/.zshrc`, `chsh`).
  - `oh-my-zsh` owns the shell setup: theme/prompt, plugins, completion
    (`compinit`), history options, key bindings, common aliases. Don't re-set those
    elsewhere. It's cloned (not the official installer, which replaces `~/.zshrc`)
    into `~/.local/share/oh-my-zsh`; its config is the `22-oh-my-zsh.zsh` snippet.
  - A tool's oh-my-zsh plugin (eg `fzf`, `zoxide`, `tmux`, `docker`, `aws`, `mise`,
    `kubectl`, `helm`) is enabled in `22-oh-my-zsh.zsh` only when the
    tool is installed (`(( $+commands[fzf] ))`), since plugins may error out without
    it; the tool's package keeps its own settings (eg fzf's integrations) in its
    snippet. These plugins share one list in a loop (plugin named like its
    command), so adding one is one word plus a comment line. The check runs at
    shell startup, not at install time, so install order doesn't matter for
    enabling them.
  - Functions in package snippets call tools with `command <tool>` when oh-my-zsh
    aliases that tool (eg `tmux`): aliases expand when the function is defined.
  - Our own aliases/options go in package snippets (no `$ZSH_CUSTOM`). Snippets that
    extend `fpath` need an `NN` below oh-my-zsh's (22), which runs `compinit`.
  - A tool package may deliberately replace an oh-my-zsh alias from its snippet: its
    snippet needs an `NN` above oh-my-zsh's (loaded after it), defines it only when the
    tool is installed, and says so in its README (eg `eza` replaces `l` /
    `la` / `ll`).
  - One owner per alias: never define the same alias in two packages relying on
    load order to pick one (eg `l` / `ll`... are only defined by eza, not by tree).
- **Editor is Neovim + NvChad** (`neovim` + `nvchad`), replacing vim:
  - The [NvChad starter](https://github.com/NvChad/starter) is vendored in
    `packages/nvchad/config/nvim` (no `.git`, no starter README) and `~/.config/nvim`
    symlinks to it, so personal changes are versioned here. Plain NvChad for now.
  - `lazy-lock.json` is committed; install runs `nvim --headless "+Lazy! restore" +qa`
    so plugins match the lockfile. Update with `:Lazy sync` and commit the lockfile.
  - linux: apt's Neovim is too old (our NvChad config needs 0.12+) and tree-sitter
    isn't packaged, so both come from their GitHub releases (latest). mac: brew.
  - The nerd font is only in mac profiles: in a devcontainer the host terminal renders it.
- **Same dotfiles on personal and work machines**: the repo holds one shared config;
  never version per-machine or per-account variants of a config, so nothing from
  the company ends up in this repo. Device profiles only choose *which* packages a
  device gets (they name public tools) and hardware values (`set`); a package's
  config is otherwise the same wherever it's installed. Per-machine differences live out of the repo:
  credentials stay where the tool keeps them, env vars go in `~/.zshrc.local`, extra
  files sit next to the linked ones, and org policy comes from the org's own tooling.
  This is why config dirs that mix shared files and machine files (eg `~/.claude`)
  are linked file by file, never as a whole directory.
- **Claude Code** (`claude-code`): native installer (`curl … | bash`) on mac and
  linux, so it auto-updates; `~/.local/bin` is put in PATH by its zsh snippet (the
  installer itself doesn't edit rc files).
  - Versioned: `~/.claude/settings.json`, `~/.claude/CLAUDE.md` (personal
    instructions for every project) and `~/.claude/rules/*.md` (one topic per file;
    use `paths` frontmatter for rules that only matter for some files). Keep them
    short, simple and valid on both machines; anything project-specific belongs in
    that project's own `CLAUDE.md`.
  - Hooks from other tools: the tool's package versions and links the script into
    `~/.claude/hooks/`; `settings.json` calls it through `$HOME` and only when the
    file exists (`[ ! -f "$f" ] || bash "$f"`), never with the absolute path the
    tool's installer writes.
  - Browser automation: the chrome-devtools MCP (`chrome-devtools-mcp`,
    `--isolated`: a temporary Chrome profile per session, so agents run it in
    parallel) by default; the Claude in Chrome extension (installed by hand,
    see `google-chrome`) only for flows needing the real, logged-in Chrome,
    eg Cloudflare Turnstile blocks the automated one. Sessions opt in with
    `claude --chrome` ("Enabled by default" stays off); `rules/browser.md` tells
    Claude which to use. Not the MCP's `--autoConnect`: it needs Chrome's remote
    debugging left on.
  - Claude runs on the host; `rules/devcontainer.md` makes it run project commands
    inside the project's devcontainer (devcontainer CLI) when there is one.
  - Not versioned: `~/.claude.json` + keychain (account), sessions, history, caches.
  - MCP servers for every project: each is its own package (eg
    `chrome-devtools-mcp`); the server is a mise tool and `install.sh`
    registers it with `claude mcp add --scope user` when `claude mcp get` doesn't
    find it, since user-scope servers only live in `~/.claude.json`. The only
    exception to "installers never edit `$HOME`", done through Claude Code's CLI.
    MCP servers that need an account or an instance (eg `grafana-mcp`: one
    server per Grafana instance, each with its URL and token) only install the
    binary; each machine registers its servers by hand, as the package README shows.
  - Work-only: managed settings from the org, plain files in `~/.claude/rules/`,
    env vars in `~/.zshrc.local`.
  - Claude Code rewrites `settings.json` (`/config`, `/model`, `/effort`). A git clean
    filter (`.gitattributes` + `packages/claude-code/git-clean-settings.sh`, set up in
    `.git/config` by its `install.sh`) strips the per-machine keys (`model`,
    `effortLevel`, `modelSettings`) and sorts the top-level keys, so they stay in the
    linked file but never reach git. Other diffs are reviewed: commit if shared,
    otherwise revert and set locally.
- **Packages own their shell env**: a package may ship `config/<NN>-<name>.zsh` and link
  it with `_dot_link_zsh` to `~/.config/zsh/`; `~/.zshrc` loads them sorted (skipping
  dangling symlinks), so `NN` is the shell load order, the same on every device
  whatever the profile. Pick `NN` by what the snippet must load before or after (eg
  brew's PATH 01, XDG 10, oh-my-zsh 22, its alias overrides above). Eg `EDITOR` lives
  in `packages/neovim/config/17-neovim.zsh`, brew's env in
  `packages/homebrew/config/01-homebrew.zsh`.
  - Only `~/.zshrc` is used: no `~/.zprofile` / `~/.zshenv` (PATH included).
    Interactive shells are the target.
  - `compinit` is run by oh-my-zsh, from its snippet (see "Shell: zsh + oh-my-zsh").
  - A snippet that prints something at startup (eg `fastfetch`) only does it
    when stdout is a terminal (`[[ -t 1 ]]`), so scripts and tools spawning a shell
    get no extra output.
- **Commits**: Claude may commit as work progresses, without asking. Always follow
  [Conventional Commits](https://www.conventionalcommits.org) (`feat(zsh): ...`,
  `fix(core): ...`, `docs: ...`), scoped by package name when it applies, one logical
  change per commit.
  - No AI attribution: no `Co-Authored-By` trailer or signature of an AI agent, even
    when Claude wrote the commit; author and committer are always the user's own git
    user (see `packages/claude-code/config/CLAUDE.md`).
  - Several Claude sessions may work on this repo: before committing, Claude checks
    `git status` for changes it didn't make and asks about them instead of
    committing them silently. Git commands run one at a time (never in parallel
    with another session's), since concurrent writes once lost a commit's objects.
  - Before committing, Claude also checks no rebase / merge / cherry-pick is in
    progress (`.git/rebase-merge`, `.git/rebase-apply`, `.git/MERGE_HEAD`,
    `.git/CHERRY_PICK_HEAD`; `git status --short` doesn't show it) and asks instead
    of committing: aborting it later resets the branch and drops those commits.
  - Commits dropped by a reset or an aborted rebase are recovered from
    `git reflog`: back up `.git`, check the lost commit descends from the branch
    (`git merge-base --is-ancestor`), then `git merge --ff-only <commit>`.
  - If git reports a missing object (`bad object`, `invalid sha1 pointer`), Claude
    stops, backs up `.git`, and checks integrity with
    `git rev-list --objects --all | cut -d' ' -f1 | git cat-file --batch-check`
    before changing any ref.

## Adding a package

1. Create a package for each missing prerequisite first (see "One package per prerequisite").
2. Create `packages/<name>/` following an existing package (eg `packages/ripgrep` for
   a tool, `packages/nvchad` for a config). A zsh snippet is `config/<NN>-<name>.zsh`,
   `NN` picked for the shell load order.
3. `install.sh`: resolve `DOT_PACKAGE_DIR` / `DOT_ROOT`, `source core/lib.sh`,
   then `_dot_require` (prerequisites), `_dot_select_package_manager || true` +
   `_dot_install_with_package_manager` (installs), `_dot_link` / `_dot_link_zsh` (config).
4. `uninstall.sh` undoing all of it in reverse (see "Every package can be uninstalled"):
   `_dot_unlink` / `_dot_unlink_zsh`, `_dot_select_package_manager || true` +
   `_dot_uninstall_with_package_manager`, plus removing clones / registrations.
5. Add `_apt.sh` / `_brew.sh` as needed, each with its `_apt_uninstall.sh` /
   `_brew_uninstall.sh`, a `README.md` (with "Prerequisites"), and a row in the root
   README table.
6. Add it to the profiles of the devices that need it (the `base` / `mac` presets when shared), after
   its prerequisites.

## Verifying

```sh
for f in install.sh uninstall.sh packages/*/install.sh packages/*/uninstall.sh packages/*/_*.sh core/lib.sh core/functions/*.sh; do bash -n "$f"; done
bash install.sh <profile> && bash install.sh <profile>   # second run must not create .bak files or duplicate lines
bash packages/<name>/uninstall.sh && bash packages/<name>/uninstall.sh   # removes all, then a no-op; reinstall after
zsh -i -c 'echo ok'
```
