# 37-mac-docker

Installs [Docker Desktop](https://www.docker.com/products/docker-desktop/)
(`docker-desktop` cask): the container runtime and the `docker` CLI.

- mac only: devcontainers don't need docker inside them.
- Simpler than gnugat, who picks a different runtime per machine (OrbStack,
  Rancher Desktop): Docker Desktop on every mac.
- The cask asks for the `sudo` password (it creates `/usr/local/bin`), so run the
  install from a terminal.
- First launch: open Docker Desktop once to finish its setup (privileged helper,
  terms).
- Not versioned: Docker Desktop's settings and `~/.docker/config.json`, which it
  writes itself (`credsStore`, `currentContext`, plugin hooks) and which lists the
  registry logins (`docker login`), per machine like gh's `hosts.yml`.
- Completions for `docker` / `docker-compose` come with the cask. oh-my-zsh's
  `docker` plugin ([22-any-oh-my-zsh](../22-any-oh-my-zsh)) adds aliases (`dps`,
  `dils`, `dxcit`...), enabled when docker is installed.
- Kubernetes: Docker Desktop's built-in cluster is the local one (Settings →
  Kubernetes → Enable Kubernetes); see [44-mac-kubectl](../44-mac-kubectl).
- Licensing: free for personal use and small companies; larger companies need a
  paid subscription.
