# Browser

Two ways to drive Chrome; pick by what the flow needs:

- **chrome-devtools MCP** (`mcp__chrome-devtools__*`), the default: its own Chrome
  with a temporary profile per session (several agents can use it at once, no
  logins kept). Use it for local apps and flows that don't need my logins, and
  whenever network requests, performance or device emulation matter.
- **Claude in Chrome** (`mcp__claude-in-chrome__*`): my real Chrome, logged in,
  tabs grouped per session. Use it only when the flow needs my real browser:
  bot protection (Cloudflare Turnstile, CAPTCHAs) that blocks the automated Chrome,
  SSO or internal tools I'm logged into, or when I ask for it.
  - Its tools only exist in sessions started with `claude --chrome`. If the task
    needs it and they're missing, stop and tell me to restart with `--chrome`;
    don't work around the block in the other browser.
  - It acts with my real accounts: open new tabs, stay on the sites the task
    needs, and leave CAPTCHAs and logins to me.
