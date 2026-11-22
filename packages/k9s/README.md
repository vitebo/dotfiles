# k9s

Installs [k9s](https://k9scli.io), a terminal UI for Kubernetes clusters.

- `~/.config/k9s/config.yaml` -> `config/config.yaml`: only our changes (none yet);
  k9s defaults apply for the rest. Linked on its own: `~/.config/k9s` also holds
  k9s state and per-cluster settings (`clusters/`, `aliases.yaml`, `skins/`...).
- `~/.config/k9s/skins/catppuccin-{latte,mocha}.yaml` -> `config/skins/`: the
  official [Catppuccin skins](https://github.com/catppuccin/k9s), vendored as is
  (MIT, `config/skins/LICENSE`).
- `~/.config/zsh/43-k9s.zsh` -> `config/43-k9s.zsh`: a `k9s` function asks the
  terminal for its light / dark mode (DSR 996, answered by Ghostty and tmux) and
  starts k9s with the matching skin (`K9S_SKIN`; Mocha when the terminal doesn't
  answer). k9s turns skin colors into fixed RGB, so unlike the other tools it
  can't follow the terminal's palette live: a running k9s keeps its skin until
  restarted. Set `K9S_SKIN` yourself to force one.
- Clusters come from the kubeconfig (`~/.kube/config`), per machine, not versioned.
- mac only: like the AWS CLI, inside devcontainers projects bring their own tools.
