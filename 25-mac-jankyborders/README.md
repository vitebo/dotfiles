# 25-mac-jankyborders

[JankyBorders](https://github.com/FelixKratz/JankyBorders) (`borders`): colored
border around the focused window, so the active AeroSpace tile stands out
(formula from the author's tap).

- `~/.config/borders/bordersrc` -> `config/bordersrc`: JankyBorders' example config
  (round, 6px, light border on the focused window, dark on the others).
- Started by AeroSpace (`after-startup-command` in `23-mac-aerospace`), like
  SketchyBar; AeroSpace's service mode `esc` re-runs `bordersrc` to apply changes.

Prerequisites:

- [23-mac-aerospace](../23-mac-aerospace)
