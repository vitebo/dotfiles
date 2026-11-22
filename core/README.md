# core

Internal functions used by the `install.sh` scripts (`_dot_*` prefix). It has no
`install.sh` of its own: it's a library, loaded with `source core/lib.sh`.

| Function | Description |
| --- | --- |
| `_dot_title`, `_dot_ok`, `_dot_warn`, `_dot_err` | standardized messages |
| `_dot_detect_os` | exports `DOT_OS` (`mac` \| `linux`) |
| `_dot_select_package_manager` | exports `DOT_PM` (`apt` \| `brew`) |
| `_dot_install_with_package_manager <dir>` | runs `<dir>/_<pm>.sh` if it exists |
| `_dot_sudo <cmd>` | runs as root (directly when already root, otherwise `sudo`) |
| `_dot_apt_install <pkgs>` | non-interactive `apt-get install` |
| `_dot_link <source> <target>` | symlink, keeping an existing regular file as `.bak` |
| `_dot_link_zsh <snippet>` | links a package's `config/<NN>-<name>.zsh` into `~/.config/zsh/` (`NN`: shell load order) |
| `_dot_profile_packages <profile>` | prints a profile's packages in install order (expands `include`, skips duplicates) |
| `_dot_require <cmds>` | fails when a prerequisite command is missing |

Each function lives in `functions/<name>.sh`; `lib.sh` loads them all.
