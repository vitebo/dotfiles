#!/usr/bin/env bash
#
# ohmyzsh.sh — installation of the Oh My Zsh framework.
#
# The user's configuration stays versioned in the repository; this module
# only guarantees the framework is present. It never overwrites an existing
# .zshrc (KEEP_ZSHRC=yes).
#
# This module only defines functions. It runs no code when loaded.

install_ohmyzsh() {
    local omz="${ZSH:-$HOME/.oh-my-zsh}"

    if [ -d "$omz" ]; then
        log_info "Oh My Zsh already installed"
        return 0
    fi

    if ! _command_exists zsh; then
        log_warn "zsh not found; skipping Oh My Zsh"
        return 0
    fi
    if ! _command_exists git; then
        log_error "git is required to install Oh My Zsh"
        return 1
    fi

    log_step "Installing Oh My Zsh"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}
