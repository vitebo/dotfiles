# 49-mac-wallpaper

Desktop wallpaper matching the Catppuccin theme: misty mountain layers in Catppuccin
Latte in light mode and Mocha in dark mode.

- `~/Pictures/Wallpapers/catppuccin-mountains.heic` -> `config/catppuccin-mountains.heic`:
  a dynamic wallpaper (one HEIC with a light and a dark image, 5120x2880), so macOS
  switches it with the appearance by itself, like its own dynamic wallpapers. No
  script runs on the switch.

Setup (by hand, once per machine): System Settings → Wallpaper → Add Photo… (or
the `+` button) → `~/Pictures/Wallpapers/catppuccin-mountains.heic`, then pick
"Automatic" (light / dark) if macOS asks. Repeat for each display if they don't
share the wallpaper.

## Credits

Photo: ["Mountains silhouetted in misty layers"](https://unsplash.com/photos/mountains-silhouetted-in-misty-layers-e1JXtCOsKTw)
by Claudio Schwarz, under the [Unsplash License](https://unsplash.com/license),
recolored to Catppuccin with [lutgen](https://github.com/ozwaldorf/lutgen-rs).

## Rebuilding

`build.sh` downloads the photo, crops it to 16:9, recolors it into Latte and Mocha
with lutgen and joins them with `make-dynamic-heic.swift`. It needs lutgen
(`brew install lutgen`, not installed by these dotfiles) and swift; commit the new
HEIC.

mac only: the wallpaper belongs to the host, devcontainers have no desktop.
