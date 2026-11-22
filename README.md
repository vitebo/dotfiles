# dotfiles

Shell and tooling configuration, organized in small, self-contained packages, installed
per device through profiles. Works on **macOS** (brew) and **Linux / devcontainers** (apt).

Inspired by [gnugat/dotfiles](https://github.com/gnugat/dotfiles).

## Installation

```sh
git clone <repo> ~/.dotfiles && bash ~/.dotfiles/install.sh <profile>
```

On a mac the profile is required (eg `work`); on linux it defaults to `devcontainer`.
Scripts are idempotent: they can be run as many times as needed.

### Uninstall

```sh
bash ~/.dotfiles/uninstall.sh <profile>          # every package of a profile, in reverse order
bash ~/.dotfiles/packages/<name>/uninstall.sh   # a single package
```

Same profile rules as `install.sh`. A package's `uninstall.sh` removes everything its
`install.sh` created: the tool, its symlinks (a `.bak` the install made is restored),
clones and plugins, mise tools, MCP registrations. User state stays (shell history,
logins, sessions, app data, Docker images), so reinstalling keeps your logins.
`homebrew`'s uninstall removes Homebrew itself, with everything brew installed.

### Devcontainers

With the [devcontainer CLI](https://github.com/devcontainers/cli) (installed on the
mac by [devcontainer](packages/devcontainer/README.md)), pass this repository
when starting the container; it gets cloned and its `install.sh` runs with the
`devcontainer` profile:

```sh
devcontainer up --workspace-folder . --dotfiles-repository <repo>
```

Nothing depends on the `~/.dotfiles` path, and the installation never prompts.

## Profiles

A profile (`profiles/<name>`) lists the packages of a device, in install order: one
package per line, `include <profile>` to reuse another profile, `#` for comments. A
package listed twice is installed once. Prerequisites must come before the packages
that need them (they check with `_dot_require`).

| Profile | Device |
| --- | --- |
| [base](profiles/base) | cross-platform shell and CLI tools (included by the others) |
| [devcontainer](profiles/devcontainer) | Linux devcontainers |
| [mac](profiles/mac) | shared by every mac (included by the mac profiles) |
| [work](profiles/work) | work MacBook |
| [personal](profiles/personal) | personal MacBook |
| [imac](profiles/imac) | iMac |

Removing a package from a profile doesn't uninstall it from machines that already have
it: run its `uninstall.sh` there.

## Structure

```
.
├── core/              # internal functions (`_dot_*`), see core/README.md
├── packages/<name>/
│   ├── install.sh     # installs the package and creates the symlinks
│   ├── uninstall.sh   # removes all of it, symlinks included
│   ├── _apt.sh        # (optional) install with apt, undone by _apt_uninstall.sh
│   ├── _brew.sh       # (optional) install with brew, undone by _brew_uninstall.sh
│   ├── config/        # config files (symlinked into $HOME)
│   └── README.md
├── profiles/<name>    # packages of a device, in install order
├── install.sh         # runs a profile's packages in order
└── uninstall.sh       # runs a profile's uninstalls in reverse order
```

A package runs where its profiles include it: mac-only packages (GUI apps) have just a
`_brew.sh` and are only in mac profiles. zsh snippets are named `config/<NN>-<name>.zsh`;
`NN` is the shell load order (eg oh-my-zsh is 22, eza's aliases load after it at 31).

```sh
bash install.sh work                   # a device profile
bash packages/ripgrep/install.sh       # a single package (its prerequisites must be installed)
DOT_PM=brew bash install.sh work       # force a package manager
```

## Packages

| Package | Description |
| --- | --- |
| [homebrew](packages/homebrew/README.md) | Homebrew |
| [zsh](packages/zsh/README.md) | zsh and its `~/.zshrc` loader |
| [curl](packages/curl/README.md) | curl |
| [git](packages/git/README.md) | git |
| [build-tools](packages/build-tools/README.md) | C compiler and make |
| [unzip](packages/unzip/README.md) | unzip |
| [ripgrep](packages/ripgrep/README.md) | ripgrep (`rg`) |
| [tree-sitter](packages/tree-sitter/README.md) | tree-sitter CLI |
| [neovim](packages/neovim/README.md) | Neovim, as the default editor |
| [nerd-font](packages/nerd-font/README.md) | JetBrainsMono Nerd Font |
| [ghostty](packages/ghostty/README.md) | Ghostty terminal (config versioned in the repo) |
| [nvchad](packages/nvchad/README.md) | NvChad config for Neovim (versioned in the repo) |
| [claude-code](packages/claude-code/README.md) | Claude Code, with config shared across machines |
| [oh-my-zsh](packages/oh-my-zsh/README.md) | oh-my-zsh: prompt, plugins, completion, history (config versioned in the repo) |
| [aerospace](packages/aerospace/README.md) | AeroSpace tiling window manager (config versioned in the repo) |
| [sketchybar](packages/sketchybar/README.md) | SketchyBar status bar, with AeroSpace workspaces |
| [jankyborders](packages/jankyborders/README.md) | JankyBorders: border around the focused window |
| [tree](packages/tree/README.md) | tree, directory listing as a tree |
| [fastfetch](packages/fastfetch/README.md) | fastfetch system summary, shown when a terminal opens |
| [bat](packages/bat/README.md) | bat (`cat` with syntax highlighting), also for man pages |
| [git-delta](packages/git-delta/README.md) | delta, syntax-highlighting pager for git |
| [fd](packages/fd/README.md) | fd, a fast alternative to `find` |
| [eza](packages/eza/README.md) | eza, a modern `ls`, used by the `l` / `la` / `ll` / `lla` aliases |
| [fzf](packages/fzf/README.md) | fzf fuzzy finder: history, files, `cd`, `**` completion |
| [zoxide](packages/zoxide/README.md) | zoxide, a smarter `cd` (`z`, `zi`) |
| [tmux](packages/tmux/README.md) | tmux terminal multiplexer, with `tz` (zoxide sessions) |
| [gh](packages/gh/README.md) | GitHub CLI, also git's credentials for github.com |
| [jq](packages/jq/README.md) | jq, command-line JSON processor |
| [docker](packages/docker/README.md) | Docker Desktop (container runtime and `docker` CLI) |
| [slack](packages/slack/README.md) | Slack, on AeroSpace workspace 9 with unread count in SketchyBar |
| [aws-cli](packages/aws-cli/README.md) | AWS CLI v2 |
| [mise](packages/mise/README.md) | mise runtime manager, with Node.js 22 as the global `node` |
| [lazygit](packages/lazygit/README.md) | lazygit, terminal UI for git (`lg`), with delta diffs |
| [lazydocker](packages/lazydocker/README.md) | lazydocker, terminal UI for docker (`lzd`) |
| [k9s](packages/k9s/README.md) | k9s, terminal UI for Kubernetes |
| [kubectl](packages/kubectl/README.md) | kubectl; local cluster from Docker Desktop's Kubernetes |
| [helm](packages/helm/README.md) | Helm, Kubernetes package manager |
| [google-chrome](packages/google-chrome/README.md) | Google Chrome web browser, the default browser |
| [wallpaper](packages/wallpaper/README.md) | Catppuccin Mocha wallpaper |
| [devcontainer](packages/devcontainer/README.md) | Dev Containers CLI (`devcontainer`), to run projects' devcontainers |
| [aws-vpn-client](packages/aws-vpn-client/README.md) | AWS Client VPN, VPN client for AWS networks |
| [chrome-devtools-mcp](packages/chrome-devtools-mcp/README.md) | Chrome DevTools MCP, lets Claude Code drive Chrome and take screenshots |
| [chafa](packages/chafa/README.md) | chafa, shows images in the terminal (also inside tmux) |
| [grafana-mcp](packages/grafana-mcp/README.md) | Grafana MCP, lets Claude Code query Grafana (servers added per machine) |
| [cloudflared](packages/cloudflared/README.md) | cloudflared, exposes a local server on a public URL (Cloudflare Tunnel) |
| [nordpass](packages/nordpass/README.md) | NordPass, password manager |
| [btop](packages/btop/README.md) | btop, terminal resource monitor |

## Local config

Machine specific tweaks live out of the repo, in `~/.zshrc.local`.
