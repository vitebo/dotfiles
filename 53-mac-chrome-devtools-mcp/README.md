# 53-mac-chrome-devtools-mcp

Installs [Chrome DevTools MCP](https://github.com/ChromeDevTools/chrome-devtools-mcp)
and registers it in Claude Code for every project on the machine, so Claude can
drive Chrome to check UI changes: navigate, click, fill forms, read the console and
network requests, and take screenshots.

- `~/.config/mise/conf.d/chrome-devtools-mcp.toml` -> `config/mise.toml`: the
  server as a mise tool (`npm:chrome-devtools-mcp`), kept across Node.js upgrades.
- MCP server `chrome-devtools`, user scope: Claude Code keeps user-scope servers
  only in `~/.claude.json` (account state, not versioned), so `install.sh` adds it
  with `claude mcp add --scope user` when it's missing. It runs the mise shim, so
  it works however Claude Code was started. Check it with `claude mcp get
  chrome-devtools`, or `/mcp` in a session.
- Chrome opens with its own profile (`~/.cache/chrome-devtools-mcp/chrome-profile`),
  separate from your browsing profile: log in there once for sites that need it.
- mac only: Claude Code and Chrome run on the host; apps in a devcontainer are
  reached through their forwarded ports (`localhost`).

Prerequisites: [40-mac-mise](../40-mac-mise), [21-any-claude-code](../21-any-claude-code),
[46-mac-google-chrome](../46-mac-google-chrome).
