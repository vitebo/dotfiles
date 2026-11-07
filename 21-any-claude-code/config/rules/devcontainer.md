# Devcontainers

Claude usually runs on the host, but when the project has a devcontainer
(`.devcontainer/devcontainer.json`, `.devcontainer.json` or
`.devcontainer/<name>/devcontainer.json`), project commands run inside it:

- Run tests, linters, formatters, builds, dev servers, package managers and project
  scripts with the devcontainer CLI, from the project root:
  `devcontainer exec --workspace-folder . <command>`
  (add `--config <path>` when there are several configurations).
- If the container isn't running, start it with
  `devcontainer up --workspace-folder .` (it reuses an existing container) and say so.
- Reading and editing files and running git stay on the host: the workspace is
  shared with the container.
- If the devcontainer can't be used (CLI or container runtime missing, `up` fails),
  explain why and ask before running the command on the host instead.
