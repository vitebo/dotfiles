# jankyborders

[JankyBorders](https://github.com/FelixKratz/JankyBorders) (`borders`): colored
border around the focused window, so the active AeroSpace tile stands out
(formula from the author's tap).

- `~/.config/borders/bordersrc` -> `config/bordersrc`: JankyBorders' example config
  (round, 6px), with Catppuccin colors following the macOS appearance: mauve on
  the focused window, surface1 on the others, Latte in light mode and Mocha in dark
  mode. [sketchybar](../sketchybar) re-runs it when macOS switches.
- Started by AeroSpace (`after-startup-command` in `packages/aerospace`), like
  SketchyBar; AeroSpace's service mode `esc` re-runs `bordersrc` to apply changes.

Prerequisites:

- [aerospace](../aerospace)
