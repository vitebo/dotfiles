# 37-mac-docker

Installs [Docker Desktop](https://www.docker.com/products/docker-desktop/)
(`docker-desktop` cask): the container runtime and the `docker` CLI.

- mac only: devcontainers don't need docker inside them.
- Simpler than gnugat, who picks a different runtime per machine (OrbStack,
  Rancher Desktop): Docker Desktop on every mac.
- The cask asks for the `sudo` password (it creates `/usr/local/bin`), so run the
  install from a terminal.
- First launch: open Docker Desktop once to finish its setup (privileged helper,
  terms). Its settings and `~/.docker/config.json` (registry logins) are per
  machine, not versioned.
- Licensing: free for personal use and small companies; larger companies need a
  paid subscription.
