#!/usr/bin/env bash
#
# symlinks.sh — generic creation of configuration symlinks.
#
# home/*   is linked into $HOME/
# config/* is linked into $HOME/.config/
#
# The logic is fully generic: adding a new file to the repository is enough
# for it to be picked up. There are no hard-coded file lists.
#
# This module only defines functions. It runs no code when loaded.

create_symlinks() {
    log_step "Linking configuration files"
    _symlink_tree "$DOTFILES_HOME" "$HOME"
    _symlink_tree "$DOTFILES_CONFIG" "$HOME/.config"
}

# Link every top-level entry of a source directory into a destination
# directory.
_symlink_tree() {
    local src_dir="$1" dest_dir="$2"

    [ -d "$src_dir" ] || return 0
    mkdir -p "$dest_dir"

    local entry name
    # Include hidden entries; guard against unmatched globs.
    shopt -s nullglob dotglob
    for entry in "$src_dir"/*; do
        name="$(basename "$entry")"
        _symlink "$entry" "$dest_dir/$name"
    done
    shopt -u nullglob dotglob
}

# Create a single symlink idempotently. Existing real files are backed up;
# existing symlinks are replaced.
_symlink() {
    local src="$1" dest="$2"

    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        log_info "ok: ${dest/#$HOME/~}"
        return 0
    fi

    if [ -L "$dest" ]; then
        log_warn "replacing symlink ${dest/#$HOME/~}"
        rm "$dest"
    elif [ -e "$dest" ]; then
        local backup="$dest.backup.$(date +%Y%m%d%H%M%S)"
        log_warn "backing up ${dest/#$HOME/~} -> ${backup/#$HOME/~}"
        mv "$dest" "$backup"
    fi

    ln -s "$src" "$dest"
    log_success "linked ${dest/#$HOME/~}"
}
