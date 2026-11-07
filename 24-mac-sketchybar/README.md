# 24-mac-sketchybar

[SketchyBar](https://github.com/FelixKratz/SketchyBar): customizable status bar,
replacing the macOS menu bar (formula from the author's tap).

- `~/.config/sketchybar` -> `config/sketchybar`: SketchyBar's demo config, with
  changes marked `dotfiles:`:
  - AeroSpace workspaces (clickable, focused one highlighted) instead of Mission
    Control spaces, from [AeroSpace's integration](https://nikitabobko.github.io/AeroSpace/goodies);
  - JetBrainsMono Nerd Font.
  - Apple logo and user name, first on the left (like gnugat's hostname item).
  - Slack ([38-mac-slack](../38-mac-slack)) icon with its unread state: number of
    mentions / DMs highlighted, `•` for unread channels, dimmed icon when Slack is
    closed. Refreshed every 10s and when the focused app changes; click opens Slack.
  - Right side: clock, volume, battery, Slack. Left side: user, workspaces, focused app.
- Started by AeroSpace (`after-startup-command` in `23-mac-aerospace`), which also
  notifies it of workspace changes (`exec-on-workspace-change`) and leaves a 40px
  top gap for it.

Setup: hide the macOS menu bar (System Settings → Control Center → Automatically
hide and show the menu bar → Always), the bar takes its place.

Reload the bar after editing its config: `alt-shift-;` then `esc` (AeroSpace's
service mode reloads both), or `sketchybar --reload`.

Prerequisites:

- [18-mac-nerd-font](../18-mac-nerd-font)
- [23-mac-aerospace](../23-mac-aerospace)
