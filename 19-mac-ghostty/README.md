# 19-mac-ghostty

Installs the [Ghostty](https://ghostty.org) terminal (brew cask).

- `~/.config/ghostty/config.ghostty` -> `config/config.ghostty`: versioned here so
  changes can be tracked. Ghostty defaults, except:
  - `cmd+t` opens a new window instead of a native tab: native tabs are separate
    windows for AeroSpace, which would tile each one. Use AeroSpace's accordion
    layout (`alt-,`) for tabs, or Ghostty splits (`cmd+d` / `cmd+shift+d`).
  - no titlebar (`macos-titlebar-style = hidden`): AeroSpace places and sizes the
    windows, so the close / minimize / maximize bar only takes space. The frame and
    rounded corners stay; `option`+drag on the frame still moves a window.
  - more padding around the text (12 points left / right, 8 top / bottom, balanced),
    instead of 2.

mac only: it's a GUI app, and linux is always a devcontainer.

Ghostty embeds JetBrains Mono and Nerd Font symbols, so NvChad icons render
without extra font setup.
