# grafana-mcp

Installs [Grafana MCP](https://github.com/grafana/mcp-grafana) (`mcp-grafana`), so
Claude Code can query Grafana: search dashboards, run Prometheus / Loki queries,
read alerts and incidents.

- `~/.config/mise/conf.d/grafana-mcp.toml` -> `config/mise.toml`: the server as a
  mise tool (`github:grafana/mcp-grafana`, the GitHub release binary).
- Only the binary is installed: each Grafana instance (eg production and staging)
  needs its own URL and token, which are per machine, so `install.sh` doesn't
  register any server in Claude Code. Add one user-scope server per instance by hand;
  Claude Code keeps them in `~/.claude.json` (account state, not versioned), token
  included, in plain text:

  ```sh
  claude mcp add --scope user grafana-<env> \
    -e GRAFANA_URL=https://grafana.example.com \
    -e GRAFANA_SERVICE_ACCOUNT_TOKEN=<token> \
    -- ~/.local/share/mise/shims/mcp-grafana
  ```

  The mise shim works however Claude Code was started. Check it with
  `claude mcp get grafana-<env>`, or `/mcp` in a session.
- Use a service account with the **Viewer** role, at least for production, so
  Claude can read but not change dashboards, alerts or annotations.
- mac only: Claude Code runs on the host.

Prerequisites: [mise](../mise), [claude-code](../claude-code).
