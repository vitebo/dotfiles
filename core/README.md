# core

Internal functions used by the `install.sh` and `uninstall.sh` scripts (`_dot_*`
prefix). It has no `install.sh` of its own: it's a library, loaded with `source core/lib.sh`.

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
| `_dot_profile_packages <profile>` | prints a profile's packages in install order (expands `include`, skips duplicates; fails when a package has no `uninstall.sh`) |
| `_dot_profile_env <profile>` | prints a profile's `set DOT_<NAME>=<value>` lines, includes expanded (a later one wins once exported) |
| `_dot_render <template> <target>` | writes `target` from `template`, replacing `@DOT_<NAME>@` with exported variables; for per-device config an app can't include (a `.bak` like `_dot_link`) |
| `_dot_unrender <target>` | undoes `_dot_render`: removes the generated file, restores a `.bak`, removes the parent dirs left empty |
| `_dot_unlink <source> <target>` | undoes `_dot_link`: removes our symlink, restores a `.bak`, removes the parent dirs left empty |
| `_dot_unlink_zsh <snippet>` | undoes `_dot_link_zsh` |
| `_dot_uninstall_with_package_manager <dir>` | runs `<dir>/_<pm>_uninstall.sh` if it exists |
| `_dot_brew_uninstall [--cask] <names>` | uninstalls the installed ones, then `brew autoremove` |
| `_dot_brew_untap <tap>` | untaps when nothing installed comes from the tap |
| `_dot_apt_remove <pkgs>` | purges the installed ones, then `apt-get autoremove` |
| `_dot_require <cmds>` | fails when a prerequisite command is missing |

Each function lives in `functions/<name>.sh`; `lib.sh` loads them all.
