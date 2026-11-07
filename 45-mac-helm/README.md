# 45-mac-helm

Installs [Helm](https://helm.sh), the Kubernetes package manager.

- Repositories and caches are per machine (`helm repo add` ...), not versioned.
- oh-my-zsh's `helm` plugin ([22-any-oh-my-zsh](../22-any-oh-my-zsh)): completion,
  when helm is installed.
- mac only, like kubectl.

Prerequisites:

- [44-mac-kubectl](../44-mac-kubectl)
