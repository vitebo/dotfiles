# mise

Installs [mise](https://mise.jdx.dev), a runtime / tool version manager, and the
global tools from its config.

- `~/.config/mise/config.toml` -> `config/config.toml`: global tools. Node.js 22
  (latest 22.x) is the default `node` / `npm`. Projects can pin other versions
  (`mise.toml`, `.tool-versions`, `.nvmrc`...).
- `install.sh` runs `mise install`, so the global tools are installed.
- oh-my-zsh's `mise` plugin ([oh-my-zsh](../oh-my-zsh)) runs
  `mise activate zsh` (puts the right versions in PATH) and sets up completion,
  when mise is installed.
- mac only: inside devcontainers, each project installs its runtimes from its own
  `devcontainer.json`.

Update the global Node.js: `mise upgrade node`. `mise use -g <tool>@<version>`
edits the versioned config.
