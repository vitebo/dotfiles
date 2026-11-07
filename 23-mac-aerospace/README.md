# 23-mac-aerospace

[AeroSpace](https://github.com/nikitabobko/AeroSpace): i3-like tiling window
manager for macOS (brew cask from the author's tap).

- `~/.config/aerospace/aerospace.toml` -> `config/aerospace.toml`: AeroSpace's
  default config, with a few changes marked `dotfiles:` (starts at login, reloads
  on save, numbered workspaces only so `alt-<letter>` keeps typing characters
  like `ç`), and the SketchyBar integration (starts it, notifies it of workspace
  changes, 40px top gap for the bar).

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
| `alt-shift-;` | service mode (`esc` reload AeroSpace + SketchyBar, `r` reset layout, `f` float/tile) |

mac only: it's a GUI app, and linux is always a devcontainer.
