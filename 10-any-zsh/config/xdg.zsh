# XDG config dir set explicitly, like gnugat: on macOS, tools that follow XDG
# (lazygit, lazydocker, k9s...) otherwise default to ~/Library/Application Support.
# Only the config dir: data / cache / state keep each tool's default location.

export XDG_CONFIG_HOME="${HOME}/.config"
