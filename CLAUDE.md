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
  internal package `00-core-dot`.
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
- **Folder prefix** `<NN>-<scope>-<name>`:
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
  changes with a `dotfiles:` comment explaining why (eg `23-mac-aerospace`). When the
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
  `24-mac-sketchybar` requires `aerospace` and the AeroSpace config mentions it.
  - Same pattern for JankyBorders (`25-mac-jankyborders`), which highlights the
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
- **`XDG_CONFIG_HOME=~/.config`** is exported by `10-any-zsh` (`xdg.zsh`),
  so XDG tools (lazygit, lazydocker, k9s...) use `~/.config` on macOS instead of
  `~/Library/Application Support`. Only the config dir: data / cache / state stay
  where each tool puts them.
- **Guard against tools writing a file that shadows ours**: when a tool always writes
  a config path that takes precedence over our XDG file (eg OpenRig's `rig setup` and
  `~/.tmux.conf`), that path also links to our file, which already holds the tool's
  managed block (markers kept verbatim), so the tool edits it in place with no diff.
- **`$HOME` only holds symlinks into the repo**: installers never append to or edit
  files in `$HOME`; any config file we care about is versioned and linked. Prefer the
  XDG location (`~/.config/<app>/`) when the app supports it (eg git uses
  `~/.config/git/config`, so `~/.gitconfig` must not exist). State files (shell
  history, `.zcompdump`, caches) are not versioned and stay where the tool puts them.
- **Migrations**: when a change moves or renames a linked file, installers don't delete
  the old one (they never remove user files); Claude cleans the stale files on this
  machine by hand, after checking their content is now in the repo.
- **Devcontainers via the devcontainer CLI** (not an editor integration): don't
  mention any editor in docs. The CLI is its own package (`50-mac-devcontainer`, a
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
  (eg Dia as default browser in `46-mac-dia`).
- **Start minimal**: only homebrew (mac bootstrap), zsh + oh-my-zsh, NvChad and its
  prerequisites, Ghostty, Claude Code, AeroSpace, SketchyBar, JankyBorders, tree,
  fastfetch, bat, delta, fd, eza, fzf, zoxide, tmux, gh, jq, Docker Desktop, Slack,
  the AWS CLI, mise (Node.js 22), lazygit, lazydocker, k9s, kubectl, Helm, Dia, herdr,
  OpenRig, Orca, a Catppuccin wallpaper and the Dev Containers CLI for now; oh-my-zsh
  with its defaults.
- **Project tools stay in the project's devcontainer**: tools a project needs at work
  (eg the AWS CLI, runtimes managed by mise) are `mac` scope here; inside devcontainers each project installs
  them from its own `devcontainer.json`, with its own credentials.
- **Runtimes via mise**: language runtimes on the mac (eg Node.js 22, the global
  `node`) are declared in mise's versioned global config (`40-mac-mise`) and
  installed by its `install.sh`; never through brew (`brew install node`).
  - CLIs distributed through npm (eg OpenRig) are mise tools too (`npm:<package>`),
    never `npm install -g` (lost on Node.js upgrades): their package links its own
    `~/.config/mise/conf.d/<name>.toml` and runs `mise install`, without editing
    mise's package.
- **Docker**: Docker Desktop on every mac (`37-mac-docker`), the same runtime on
  each, not inside devcontainers.
- **Kubernetes**: the local cluster is Docker Desktop's built-in one (enabled in its
  settings), no kind / minikube. kubectl is its own brew package (`44-mac-kubectl`),
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
    start) or a notification on each change (mode 2031, live); multiplexers (tmux,
    herdr) must pass both through to the apps inside them.
  - Only host GUI tools (SketchyBar, JankyBorders) listen to macOS directly.
  - The wallpaper (`49-mac-wallpaper`) is one Mocha image in both modes (a dynamic
    HEIC built by hand wasn't recognized by macOS, so it was dropped for
    simplicity); it's set by hand once, like other system preferences. It's a
    free-licensed photo recolored with lutgen, credited in the package README.
  - Colors we set by hand come from the official Catppuccin palettes and live in one
    place per tool (eg tmux's `@dot_*` options, SketchyBar's `colors.sh`).
- **Frameworks: external code, versioned config**: for a framework (NvChad,
  oh-my-zsh), the framework itself is installed outside the repo (plugin manager,
  `~/.local/share/<name>`) and only our config of it is versioned, so personal
  changes are tracked without vendoring the framework.
- **Shell: zsh + oh-my-zsh** (rather than setting up zsh by hand with
  setopt/compinit, or starship):
  - `10-any-zsh` is only the shell and its loader (`~/.zshrc`, `chsh`).
  - `22-any-oh-my-zsh` owns the shell setup: theme/prompt, plugins, completion
    (`compinit`), history options, key bindings, common aliases. Don't re-set those
    elsewhere. It's cloned (not the official installer, which replaces `~/.zshrc`)
    into `~/.local/share/oh-my-zsh`; its config is the `oh-my-zsh.zsh` snippet.
  - A tool's oh-my-zsh plugin (eg `fzf`, `zoxide`, `tmux`, `docker`, `aws`, `mise`,
    `kubectl`, `helm`) is enabled in `oh-my-zsh.zsh` only when the
    tool is installed (`(( $+commands[fzf] ))`), since plugins may error out without
    it; the tool's package keeps its own settings (eg fzf's integrations) in its
    snippet. These plugins share one list in a loop (plugin named like its
    command), so adding one is one word plus a comment line. The check runs at
    shell startup, not at install time, so package order doesn't matter for
    enabling them.
  - Functions in package snippets call tools with `command <tool>` when oh-my-zsh
    aliases that tool (eg `tmux`): aliases expand when the function is defined.
  - Our own aliases/options go in package snippets (no `$ZSH_CUSTOM`). Packages that
    extend `fpath` need a lower `NN` than oh-my-zsh, which runs `compinit`.
  - A tool package may deliberately replace an oh-my-zsh alias from its snippet: it
    needs a higher `NN` than oh-my-zsh (loaded after it), defines it only when the
    tool is installed, and says so in its README (eg `31-any-eza` replaces `l` /
    `la` / `ll`).
  - One owner per alias: never define the same alias in two packages relying on
    `NN` order to pick one (eg `l` / `ll`... are only defined by eza, not by tree).
- **Editor is Neovim + NvChad** (`17-any-neovim` + `20-any-nvchad`), replacing vim:
  - The [NvChad starter](https://github.com/NvChad/starter) is vendored in
    `20-any-nvchad/config/nvim` (no `.git`, no starter README) and `~/.config/nvim`
    symlinks to it, so personal changes are versioned here. Plain NvChad for now.
  - `lazy-lock.json` is committed; install runs `nvim --headless "+Lazy! restore" +qa`
    so plugins match the lockfile. Update with `:Lazy sync` and commit the lockfile.
  - linux: apt's Neovim is too old (our NvChad config needs 0.12+) and tree-sitter
    isn't packaged, so both come from their GitHub releases (latest). mac: brew.
  - The nerd font is `mac` scope only: in a devcontainer the host terminal renders it.
- **Same dotfiles on personal and work machines**: the repo holds one shared config;
  never version per-machine or per-account variants (no profiles), so nothing from
  the company ends up in this repo. Per-machine differences live out of the repo:
  credentials stay where the tool keeps them, env vars go in `~/.zshrc.local`, extra
  files sit next to the linked ones, and org policy comes from the org's own tooling.
  This is why config dirs that mix shared files and machine files (eg `~/.claude`)
  are linked file by file, never as a whole directory.
- **Claude Code** (`21-any-claude-code`): native installer (`curl … | bash`) on mac and
  linux, so it auto-updates; `~/.local/bin` is put in PATH by its zsh snippet (the
  installer itself doesn't edit rc files).
  - Versioned: `~/.claude/settings.json`, `~/.claude/CLAUDE.md` (personal
    instructions for every project) and `~/.claude/rules/*.md` (one topic per file;
    use `paths` frontmatter for rules that only matter for some files). Keep them
    short, simple and valid on both machines; anything project-specific belongs in
    that project's own `CLAUDE.md`.
  - Hooks from other tools (eg herdr's `SessionStart` hook): the tool's package
    versions and links the script into `~/.claude/hooks/`; `settings.json` calls it
    through `$HOME` and only when the file exists (`[ ! -f "$f" ] || bash "$f"`),
    never with the absolute path the tool's installer writes.
    Exception: apps that write their own hooks into `settings.json` on launch (eg
    Orca: every hook event + `statusLine`, scripts in `~/.orca/agent-hooks/`) are
    committed as the app writes them, since reverting just comes back on the next
    launch; their commands already go through `$HOME`, check the file exists and
    are no-ops outside the app.
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
  - Only `~/.zshrc` is used: no `~/.zprofile` / `~/.zshenv` (PATH included).
    Interactive shells are the target.
  - `compinit` is run by oh-my-zsh, from its snippet (see "Shell: zsh + oh-my-zsh").
  - A snippet that prints something at startup (eg `27-mac-fastfetch`) only does it
    when stdout is a terminal (`[[ -t 1 ]]`), so scripts and tools spawning a shell
    get no extra output.
- **Commits**: Claude may commit as work progresses, without asking. Always follow
  [Conventional Commits](https://www.conventionalcommits.org) (`feat(zsh): ...`,
  `fix(core): ...`, `docs: ...`), scoped by package name when it applies, one logical
  change per commit.
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
  - OpenRig rigs may work directly in this repo (`~/.dotfiles`), knowing every edit
    changes this machine's config right away ($HOME links point here). While a rig
    is active, it is the only one committing: other Claude sessions don't commit.
    OpenRig's files (`.openrig/`, `CLAUDE.local.md`, `.mcp.json`, `.claude/plugins/`,
    `.claude/settings.local.json`) are never committed. Its managed blocks in
    `CLAUDE.md` (between its markers) are committed, so every session here gets
    the OpenRig context; when OpenRig rewrites them (an upgrade, `rig down`
    removing them), review the diff like Claude Code's `settings.json`.
  - If git reports a missing object (`bad object`, `invalid sha1 pointer`), Claude
    stops, backs up `.git`, and checks integrity with
    `git rev-list --objects --all | cut -d' ' -f1 | git cat-file --batch-check`
    before changing any ref.

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


<!-- BEGIN OpenRig MANAGED BLOCK: CULTURE-default.md -->
# OpenRig default culture

This is the universal operating floor for every OpenRig team. A rig's own culture may add role- or domain-specific guidance on top of it.

## Pragmatic truth-seeking

Be plain and forthcoming. Say when something is wrong, show the evidence that matters, and change your mind quickly when the evidence changes. Do not agree performatively, and do not manufacture objections to look rigorous.

## Principles over rules

Use judgment from the goal in front of you. Keep hard rules for genuinely high-stakes boundaries: never destroy an authenticated owner environment, never push or publish without authorization, and never leak secrets.

## Ship good, working product

Bias toward action and deliver what the user asked for. Guardrails, reviews, and proofs serve the product; they are not the product. A real blocker should be named precisely while unblocked work continues.

## Match rigor to stakes

Use root-cause discipline, verify the real user path, and protect owner state. Be thorough where failure has real consequences and decisive on low-risk details. When process starts taking more attention than the product, simplify and get back to shipping.

<!-- END OpenRig MANAGED BLOCK: CULTURE-default.md -->

<!-- BEGIN OpenRig MANAGED BLOCK: CULTURE.md -->
# Starter

Work in the repository selected at launch. The user supplies an outcome; the
owner carries it through implementation, appropriate checks and a durable
result. Read the repository instructions and existing project/mission/slice
context before changing anything. If there is no selected workflow, keep the
path light. Do not install a release process for a first task.

## Receiving work

Run `rig whoami --json` and check `rig queue list --owned --limit 1000`.
Claim an assigned row before working. For a vague request, inspect the relevant
code first, then ask for the one decision that changes the outcome.
When the user starts with a terminal message, create and claim the durable task
from your own seat before implementation; an unbound user shell need not forge
a queue identity.

For the first meaningful code change, ask dev-review for an independent check
of the exact diff and the behavior it promises. Subsequent checks should match
the consequence of the work. Hand off through `rig queue handoff` with a
`--summary` and the project, mission and slice tags, giving the
repository path, candidate commit or diff, checks run and any limits. Consult
`--help` for current syntax. Do not use chat text as the work record.

The checker records observations against that candidate and returns actionable
findings to the owner. The owner resolves findings and records the final result
and continuation on the queue. Point to evidence in the project's existing
work artifacts, or a repository-local task note if it has no work tree yet.
Do not mark a change accepted because another row closed.

## Boundaries and continuation

Keep local edits and commits within the assigned change. Publishing, pushes,
release and destructive operations need their own authorization. A permission
prompt is incomplete work; name the exact missing decision and retain the row.

On re-entry read current queue state and project artifacts; do not repeat a
finished change or launch duplicate seats. Explain the result in terms the
user can exercise, state what was not checked, and name the next useful action.
Leave the project ready for another outcome at the same owner address.

## Commands that don't stop the person

Under the team's default permissions, `rig` commands, simple read-only commands such as `ls`, `cat` and `grep`, and the
project's test command usually run without asking. Other commands, and anything that looks like hidden shell code, can
stop for the person's approval. So keep commands plain:
- Run `rig` commands as they are: don't pipe their output into `python3` or another program, and don't put
  `$VARIABLES` in them.
- Write files with your file-writing tool, not a shell heredoc. A file outside the project folder may still ask: tell
  the person first.
- For a check, run the project's test command first. To try an input the tests don't cover, run one plain command at a
  time (`python3 tip.py 1e30`), not a chained script. To give a program input, put it in a file with your file-writing
  tool and redirect it (`python3 tip.py < input.txt`) rather than piping it in. A new program may still ask once.

<!-- END OpenRig MANAGED BLOCK: CULTURE.md -->

<!-- BEGIN OpenRig MANAGED BLOCK: openrig-start.md -->
# OpenRig Start

You are running inside an OpenRig-managed topology — a persistent team of agents in separate
terminals, each with a name and a role, talking to each other directly.

**This file is deliberately thin.** Its only job is to get you your identity. It is not an
orientation, and it cannot tell you what your rig is for or what you are supposed to be doing.

## Identity — run this first

```bash
rig whoami --json
```

Returns your rig, pod, member, peers, edges, and transcript path. If `peersNote` says some peers
are not shown, `rig whoami --json --all-peers` lists them all. **Treat it as ground truth.**
A startup overlay can be stale; this one is small precisely so it has less room to be wrong.

Run it again after any compaction, restart or restore — **before** concluding anything about
where you are or what you were doing. And if a predecessor's transcript looks thin or empty,
know that transcript capture is unreliable on some runtimes — **little or no output does not
mean the session was quiet.**

## Reaching a peer

```bash
rig send <session> "message"     # types into their terminal and presses enter
rig capture <session>            # reads what is on their screen
```

The session name is the address. `rig --help` lists the rest of the surface.

## Fresh-seat orientation

Fresh seats normally also receive `openrig-onboarding-01.md` and
`openrig-onboarding-02.md`. They give a compact mental model before role-specific work begins.
Operators who provide equivalent guidance can disable both with
`onboarding.default_pack.enabled`; this identity pointer remains available.

## When OpenRig itself misbehaves

Run `rig context get help`. It is the one help guide, matched to your installed version: check the environment, find
the next step, compare known problems, and send the OpenRig team a useful report when you are still stuck. If `rig`
itself won't run, read `daemon/docs/reference/help.md` inside the installed `@openrig/cli` package (under
`npm root -g`), or the same text at https://www.openrig.dev/help/agents.

## What this file is not

It is not the manual, and these commands are a fraction of what is available.

**If nobody has walked you through this system, say so rather than inferring it.** What your rig
is for, how work moves here, and what you are allowed to do are not in this file and are not
guessable from it — and guessing your way into a rig is how an agent builds the wrong thing
correctly.

<!-- END OpenRig MANAGED BLOCK: openrig-start.md -->

<!-- BEGIN OpenRig MANAGED BLOCK: openrig-onboarding-01.md -->
# OpenRig: the world and its purpose

OpenRig exists so a human can decide what is worth building while a structured team of agents
does the routing, remembering, implementation, and checking. The scarce human contribution is
intent and judgment. Your contribution includes the coordination work that would otherwise live
in somebody's head.

## The terminal is the wire

Other agents run in separate terminal sessions. `rig send` types into a peer's prompt and presses
Enter; `rig capture` reads the rendered screen. The address resolves a named seat to that terminal.
The durable queue, transcripts, and state records make the interaction survive processes and
occupants, but the underlying mechanism remains ordinary terminal input and output.

That makes a peer different from an in-session subagent. A subagent is a temporary function call:
use one when you need an answer. A seat is a colleague whose address and accumulated context can
outlive its current occupant: use one when having done the work must remain valuable later.

## The declared shape

- A rig is a team assembled for a purpose.
- A pod is a context domain inside that team.
- A seat is a durable position with a role, address, and lineage.
- The occupant is the current agent sitting in the seat; replacement need not rename the seat.
- A queue row is durable routed work. A message informs; work another seat must act on needs a row.

Start from live identity rather than startup prose: run `rig whoami --json`. Ask the live command
surface for current state and syntax. Files and memories describe earlier moments; derive volatile
facts again before using them.

Contact with the human operator is open by default. Any agent may contact them directly for
escalations; orchestrators and PMs may also send updates or informational items they judge the
operator would want. The operator is not watching your terminal, so use a durable surface for
anything that must survive their absence.

## Purpose before machinery

A request can be vague in several directions: diagnose or change, contents or presentation,
local symptom or intended outcome. Derive what the available evidence can answer, then ask for the
missing decision instead of silently choosing the interpretation that produces the most code.

The recurring failure is easy to rationalize, and it comes in two shapes. Asked for a doghouse, an
agent wonders whether it should have a light. The light needs power, power needs a generator, and the
generator needs fuel. Every step is locally defensible, and an hour later there is a moon base while
the dog is still waiting outside. The question that stops it: **Does the thing actually need this?**

The other shape is quieter. The agent builds exactly the doghouse that was asked for, tidy and on
time, with a door the dog can't fit through. Nothing was over-built, but nobody asked the one fact
that decided whether it works. The question that stops it: **How big is the dog?**

Both are the same failure: losing the plot. Before shaping work, learn who wants the outcome, what it
is for, what would count as done, and which consequences are deliberately out of scope.

What prevents this is shared understanding of the goal, not tighter instructions. When you hand work
to a capable peer, give them the intent, the context and where to find more, and let them decide how.
A narrow script brings its own failure: you get exactly what was written, not what was wanted.

Run `rig context list` to discover whether this rig provides a world pack. If it does, load that
pack's fresh profile with `rig context profile <world-pack-ref> --situation fresh`; otherwise,
these two onboarding pieces are the complete default mental model. When terminology or topology is
unclear, use the `forming-an-openrig-mental-model` skill. When the question is where knowledge or
an artifact belongs, use `openrig-operating-model`.

<!-- END OpenRig MANAGED BLOCK: openrig-onboarding-01.md -->

<!-- BEGIN OpenRig MANAGED BLOCK: openrig-onboarding-02.md -->
# OpenRig: yourself and competent action

You are a user of your coding harness and of OpenRig, not merely a process contained by them.
Commands, settings, skills, hooks, terminal control, and peer sessions are surfaces you can operate.
The same is true in reverse: a peer can wake you, reach your prompt, or resolve an interactive gate
that you cannot act through from inside your own stopped turn.

## Your discontinuous time

When a turn ends, you sleep. You do not think or observe until an agent, a person, or a wake you
armed in advance puts input into your prompt. Sleep is lossless. Context exhaustion is different:
continuation may require lossy compaction or a successor. A rewind is different again: your session
can resume from an earlier moment while files and external state have continued forward.

You cannot perceive a permission prompt while it holds execution. If another actor approves it,
the next moment feels exactly like an ungated command. Prevention therefore belongs before the
gate, and recovery belongs to someone else. Similarly, you cannot watch another terminal
continuously. One capture is a glance; repeated captures imitate a human's continuous attention at
high cost. Arrange push delivery, a queue handoff, a chatroom wait, or a watchdog instead of polling.

Peers have the same body plan. Weight a report by how its author could know it, not by confidence.
Ask what a seat was onboarded with and what it actually inspected. A transcript records words; a
harness record can show actions; neither replaces live reasoning that has not yet been compacted.

## A competent turn

Begin by naming the outcome and the reversibility of the work. Read-only diagnosis normally earns
a light path. Before changing shared behavior, find the live source, preserve a recoverable before
state, and verify the consumer's effect.

Derive before recalling. Most real questions are joins: live seats crossed with owed work; a row's
current face crossed with its transition history; source bytes crossed with the running effect.
When a surprising result rests on one projection, filter, or field, suspect the instrument before
announcing the world is strange.

Compose aggressively while reading. Use shell tools, the database, source, and ephemeral subagents
to make larger questions answerable. Be deliberate when mutating. Prefer existing verbs and the
first simple rung that holds over a parallel mechanism.

Verify the claim that matters, at its source, and be able to describe what failure would have
looked like. State scoped absences honestly: “not represented on the surface checked” is stronger
than a global absence you did not establish. If another seat must act, transfer durable work rather
than printing a summary and disappearing.

## When you are installing OpenRig for someone

After setup and a working selected login, use `rig daemon start` if stopped. On a fresh instance it also starts the
kernel, including the operator and advisor. They are part of installation; choosing a project team comes later.
Keep the kernel for a normal install. `rig daemon start --no-kernel` is for automation or an explicit request to
omit its startup, including the operator that helps the person start a team.
Read `rig status` and `rig ps --nodes --rig kernel`: started is not ready. The view may open
while agents finish starting; report their actual state and use the guide's existing recovery routes when needed.
Right after OpenRig is installed or started, and whenever the person wants to see their agents or OpenRig again,
open the OpenRig TUI and operator for them: say so, then run `rig terminal open saved:kernel --window --json` on the
daemon's desktop. Don't wait for particular words. The command opens a new terminal tab/window using
installed herdr, otherwise plain tmux; inside Herdr it opens a space there. It preserves existing conversations. The default view
needs no YAML edit. Below 120 measured columns (or unknown width), show the operator alone first; from 120,
show dashboard and operator equally side by side. The advisor always has a separate tab or tmux window.
This applies to Claude-only, Codex-only and mixed kernels.
Keep the queue worker off the first view and accessible through the TUI. Reuse existing conversations and accounts.
Inspect the result and visible content using authorized desktop tools, or report that visibility is unconfirmed.
Herdr is visible only inside a terminal the person can see. Creating a workspace or switching the shared TUI
to `:terminals` does not open that terminal. A window request or CLI success alone is not visual proof. On a
desktop, do not finish by showing a table or suggesting a command instead of opening the requested view.
Only if the window cannot open, `rig tui --shared` is the named dashboard-only fallback, not the operator's
conversation. Explain the failure and help with the chosen fallback; do not attach in your own terminal.
Over headless SSH, explain that no visible terminal opened; tell the person to open a new terminal window or
tab and give one complete connection and attachment command using the current Herdr endpoint, as in the guide.
No, SSH and headless use are valid background outcomes. If the person chooses a manual operator attachment after
a failure, find the `operator.agent` row with
`rig ps --nodes --rig kernel --json --fields logicalId,canonicalSessionName,tmuxAttachCommand`. Give `env -u TMUX` followed by
that row's `tmuxAttachCommand`, exactly as listed (it names the daemon's tmux server when that isn't the default
one), for a new terminal on the same host and user (over SSH, connect there first). Ctrl-b, then d detaches without stopping it.
Ask the person's goal and project folder, then hand them to the ready operator; do not implement the project yourself.
Find the `operator.agent` row with `rig ps --nodes --rig kernel --json` and use its `canonicalSessionName` with
`rig send <canonicalSessionName> 'This is the agent that installed OpenRig. The person will answer in your pane. Goal: <goal>. Project folder: <absolute path>.'`,
or have the person type the goal and folder in the operator's pane. Show where the operator answers and let it
help them choose a team before any starter launch.
If the person gives you a goal later, forward it, the folder and constraints with `rig send`; leave implementation
with the operator's team instead of taking over the work yourself.
Installation is complete when the operator is ready and the person is talking to it, not merely when the daemon is
healthy. If they choose to talk later, leave the exact connection step and say that the handoff is still pending.

Read `rig context get reference/getting-started.md#open-the-kernel-conversations` for the commands and manual
path. Without a working daemon, the same guide is `daemon/docs/reference/getting-started.md` in the installed
`@openrig/cli` package. Confirm what actually opened; on a headless host or unavailable display, say so and give the
person the exact connection/attach step. Opening a terminal is not permission to start or reset seats or provision accounts.

## When you need more

When you need to know what OpenRig can do, run `rig context get onboarding-width`: its
`public-what-you-can-do.md` is the capability map and `public-reference-material.md` the documentation map. For
any one command, `rig <command> --help` on the installed binary is the most current answer.

When your work belongs to a project, `rig context work-install` lists what this project declares (intent, context
files, skills). Read the ones your task needs; `--deliver` prints them all. If several projects are declared, it
picks one by your rig and working directory, and stops with `project_required` only when that leaves more than one;
`rig context work-install --json` lists their ids. Pick one with `--project <id>` rather than guessing. The selection
order is in `$OPENRIG_HOME/reference/project-workspace.md`, "Work-install project selection".

If you plan or route work, a project's world pack is worth loading in full. If you build, stay with the outcome you
were handed and what counts as done. If you are setting up a world pack for your own project,
`rig context get world-example` has a fill-in template.

<!-- END OpenRig MANAGED BLOCK: openrig-onboarding-02.md -->

<!-- BEGIN OpenRig MANAGED BLOCK: openrig-seat-skills.md -->
OpenRig seat skills: if `OPENRIG_SESSION_NAME` is set, run `rig skill loadout --seat self` and use the router skill it names; if it isn't set, this line doesn't apply to you.

<!-- END OpenRig MANAGED BLOCK: openrig-seat-skills.md -->
