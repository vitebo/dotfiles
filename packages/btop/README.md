# btop

Installs [btop](https://github.com/aristocratos/btop), a terminal resource monitor
(CPU, memory, disks, network, processes): `btop`.

- `~/.config/btop/btop.conf` -> `config/btop.conf`: only our changes; btop's defaults
  apply for the rest (`btop --default-config` prints them).
  `save_config_on_exit = false`, so settings changed in btop's menu last only until
  it quits: make them permanent in `config/btop.conf`.
- mac only: it monitors the host; inside a devcontainer it would only see the
  container.

Colors: btop's built-in `TTY` theme, made of the terminal's ANSI colors, so it follows
Ghostty's Catppuccin Latte / Mocha.
