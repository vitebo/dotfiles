# 44-mac-kubectl

Installs [kubectl](https://kubernetes.io/docs/reference/kubectl/)
(`kubernetes-cli` formula), the Kubernetes command line tool.

- Its own package, independent of the `kubectl` Docker Desktop ships in
  `/usr/local/bin` (`/opt/homebrew/bin` comes first in PATH, so this one is used).
- Clusters and credentials live in the kubeconfig (`~/.kube/config`), per machine,
  not versioned.
- oh-my-zsh's `kubectl` plugin ([22-any-oh-my-zsh](../22-any-oh-my-zsh)), when
  kubectl is installed: completion and aliases (`k`, `kgp` get pods, `kaf` apply -f,
  `kl` logs, `kcuc` use-context...).
- tmux's status line ([34-any-tmux](../34-any-tmux)) shows the current context on
  the right (`kubectl config current-context`, cut to the cluster name for EKS
  ARNs), when kubectl is installed.
- mac only: inside devcontainers, projects bring their own tools.

## Local cluster

The local Kubernetes cluster is Docker Desktop's ([37-mac-docker](../37-mac-docker)),
nothing else to install: Docker Desktop → Settings → Kubernetes → Enable Kubernetes.
It adds a `docker-desktop` context to the kubeconfig:

```sh
kubectl config use-context docker-desktop   # or: kcuc docker-desktop
kubectl get nodes
```
