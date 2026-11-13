# 24-mac-sketchybar

[SketchyBar](https://github.com/FelixKratz/SketchyBar): customizable status bar,
replacing the macOS menu bar (formula from the author's tap).

- `~/.config/sketchybar` -> `config/sketchybar`: SketchyBar's demo config, with
  changes marked `dotfiles:`:
  - AeroSpace workspaces (clickable, focused one highlighted, the ones without
    windows dimmed) instead of Mission Control spaces, from [AeroSpace's integration](https://nikitabobko.github.io/AeroSpace/goodies);
  - AeroSpace's binding mode (eg `service`), highlighted in place of the
    focused app while it isn't `main`, so the other items don't move; AeroSpace
    notifies the bar (`on-mode-changed`).
  - JetBrainsMono Nerd Font.
  - Apple logo and user name, first on the left.
  - Slack ([38-mac-slack](../38-mac-slack)) icon with its unread state: number of
    mentions / DMs highlighted, `•` for unread channels, dimmed icon when Slack is
    closed. Refreshed every 10s and when the focused app changes; click opens Slack.
  - AWS Client VPN ([52-mac-aws-vpn-client](../52-mac-aws-vpn-client)) cloud icon:
    with a lock when connected, crossed out and dimmed when disconnected or the
    client is closed, an outline with `…` while connecting. Read from the tray state the client logs to
    `~/.config/AWSVPNClient/logs`, refreshed every 5s; click opens the client.
  - Right side: clock, volume, battery, Slack, AWS VPN. Left side: user,
    workspaces, focused app.
  - Catppuccin colors (`colors.sh`), Latte in light mode and Mocha in dark mode, read
    from the macOS appearance. An invisible item reloads the bar when macOS switches
    (`AppleInterfaceThemeChangedNotification`) and re-runs JankyBorders' `bordersrc`
    ([25-mac-jankyborders](../25-mac-jankyborders)) when it's running.
  - Light / Dark / System button (right side): the icon shows the macOS appearance
    (sun, moon, or half for System, macOS' Auto); a click opens a popup to pick
    another, and every tool follows. It calls SkyLight's private appearance
    functions through JXA (`plugins/appearance_mode.sh`), since macOS has no public
    command for Auto: a macOS update may break the button, nothing else.
- Started by AeroSpace (`after-startup-command` in `23-mac-aerospace`), which also
  notifies it of workspace and mode changes (`exec-on-workspace-change`,
  `on-mode-changed`) and leaves a 40px
  top gap for it.

Setup: hide the macOS menu bar (System Settings → Control Center → Automatically
hide and show the menu bar → Always), the bar takes its place.

Reload the bar after editing its config: `alt-shift-;` then `esc` (AeroSpace's
service mode reloads both), or `sketchybar --reload`.

Prerequisites:

- [18-mac-nerd-font](../18-mac-nerd-font)
- [23-mac-aerospace](../23-mac-aerospace)
