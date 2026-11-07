# 43-mac-k9s

Installs [k9s](https://k9scli.io), a terminal UI for Kubernetes clusters.

- `~/.config/k9s/config.yaml` -> `config/config.yaml`: only our changes (none yet);
  k9s defaults apply for the rest. Linked on its own: `~/.config/k9s` also holds
  k9s state and per-cluster settings (`clusters/`, `aliases.yaml`, `skins/`...).
- Clusters come from the kubeconfig (`~/.kube/config`), per machine, not versioned.
- mac only: like the AWS CLI, inside devcontainers projects bring their own tools.
