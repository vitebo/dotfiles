# 23-mac-aerospace

[AeroSpace](https://github.com/nikitabobko/AeroSpace): i3-like tiling window
manager for macOS (brew cask from the author's tap).

- `~/.config/aerospace/aerospace.toml` -> `config/aerospace.toml`: AeroSpace's
  default config, with a few changes marked `dotfiles:` (starts at login, reloads
  on save, numbered workspaces only so `alt-<letter>` keeps typing characters
  like `ç`), 14px gaps around windows (29px on the sides, lined up with
  SketchyBar's items; the top one per monitor, since the MacBook's notched display
  reserves 32pt at the top), and the SketchyBar / JankyBorders
  integration (starts them, notifies SketchyBar of workspace and mode changes and
  of windows moved to another workspace, extra top gap for the bar), and apps
  pinned to workspaces (Slack on 9).

First launch: open AeroSpace and grant it the Accessibility permission
(System Settings → Privacy & Security → Accessibility).

Main bindings (`alt` is `Option ⌥`):

| Keys | Action |
| --- | --- |
| `alt-h/j/k/l` | focus left / down / up / right |
| `alt-shift-h/j/k/l` | move window |
| `alt-1` … `alt-9` | go to workspace |
| `alt-shift-1` … `alt-shift-9` | move window to workspace |
| `alt-/` / `alt-,` | tiles / accordion layout (toggles orientation) |
| `alt--` / `alt-=` | resize |
| `alt-tab` | previous workspace |
| `alt-enter` | new Ghostty window (asks once to let AeroSpace control Ghostty) |
| `alt-shift-;` | service mode (`esc` reload AeroSpace + SketchyBar + JankyBorders, `r` reset layout, `f` float/tile) |

mac only: it's a GUI app, and linux is always a devcontainer.
