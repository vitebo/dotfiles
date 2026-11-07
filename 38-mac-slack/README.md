# 38-mac-slack

Installs [Slack](https://slack.com) (`slack` cask, auto-updates). mac only: it's a
GUI app. Login is per machine (personal / work workspaces), nothing versioned.

## Integrations

- [23-mac-aerospace](../23-mac-aerospace): Slack windows always open on workspace 9
  (`on-window-detected`, app id `com.tinyspeck.slackmacgap`).
- [24-mac-sketchybar](../24-mac-sketchybar): Slack icon with its unread state, read
  from its Dock badge (number of mentions / DMs highlighted, `•` for unread channels,
  dimmed when Slack is closed), refreshed every 10s and when switching apps; click
  opens Slack. Notification contents aren't shown: macOS doesn't expose them, and
  Slack's API would need a per-account token.

Unlike gnugat: no Catppuccin theme for now.
