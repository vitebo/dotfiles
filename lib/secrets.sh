#!/usr/bin/env bash
#
# secrets.sh — management of the local (never versioned) secrets file.
#
# Secrets live at ~/.config/dotfiles/secrets.zsh. The repository only ships
# secrets.example.zsh to document the expected variables. The .zshrc sources
# the real file only when it exists.
#
# This module only defines functions. It runs no code when loaded.

setup_secrets() {
    local dir="$HOME/.config/dotfiles"
    local target="$dir/secrets.zsh"
    local example="$DOTFILES_ROOT/secrets.example.zsh"

    mkdir -p "$dir"

    if [ -f "$target" ]; then
        log_info "secrets.zsh already present"
        return 0
    fi

    if [ ! -f "$example" ]; then
        log_warn "secrets.example.zsh not found; skipping"
        return 0
    fi

    cp "$example" "$target"
    log_success "created $target — fill in your real values"
}
