# devcontainer

Installs the [Dev Containers CLI](https://github.com/devcontainers/cli)
(`devcontainer`): starts a project's devcontainer from its `devcontainer.json` and
runs commands in it.

- `~/.config/mise/conf.d/devcontainer.toml` -> `config/mise.toml`: the CLI as a mise
  tool (`npm:@devcontainers/cli`), installed by `install.sh` with mise's Node.js and
  kept across Node.js upgrades (brew's `devcontainer` formula would bring brew's
  Node.js).
- mac only: devcontainers run on the mac's Docker, the CLI drives them from the host.
- Its own package (not part of [docker](../docker)), so helper scripts
  for working with devcontainers can live here.

Common commands, from a project's root:

```sh
devcontainer up --workspace-folder .                          # start (or reuse) the container
devcontainer exec --workspace-folder . <command>              # run a command inside it
devcontainer up --workspace-folder . --dotfiles-repository <repo>   # with these dotfiles inside
```

Claude Code runs project commands through it when a project has a devcontainer
(`rules/devcontainer.md` in [claude-code](../claude-code)).

Prerequisites:

- [mise](../mise)
- [docker](../docker) (to run the containers; not needed to install)
