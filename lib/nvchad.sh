#!/usr/bin/env bash
#
# nvchad.sh — installation of NvChad requirements and configuration.
#
# The custom configuration lives in the repository under config/nvim and is
# placed by the symlink module. This module only:
#   * makes sure Neovim is available
#   * scaffolds the NvChad starter into the repo the first time (so it can
#     then be versioned)
#   * syncs plugins headlessly
#
# This module only defines functions. It runs no code when loaded.

install_nvchad() {
    if ! _command_exists nvim; then
        log_warn "neovim not installed; skipping NvChad"
        return 0
    fi

    _scaffold_nvchad
    _sync_nvchad_plugins
}

# Populate config/nvim from the NvChad starter the first time only. Existing
# configuration is never touched.
_scaffold_nvchad() {
    local repo_nvim="$DOTFILES_CONFIG/nvim"

    if [ -f "$repo_nvim/init.lua" ]; then
        log_info "NvChad configuration already present in repository"
        return 0
    fi

    if ! _command_exists git; then
        log_error "git is required to scaffold NvChad"
        return 1
    fi

    log_step "Scaffolding NvChad starter into config/nvim"
    local tmp
    tmp="$(mktemp -d)"
    git clone --depth 1 https://github.com/NvChad/starter "$tmp/nvim"
    rm -rf "$tmp/nvim/.git"
    mkdir -p "$repo_nvim"
    cp -R "$tmp/nvim/." "$repo_nvim/"
    rm -rf "$tmp"
    log_success "NvChad starter added to config/nvim (commit it to version it)"
}

# Sync plugins without opening an interactive session. The nvim config is
# expected to be already symlinked into ~/.config/nvim.
_sync_nvchad_plugins() {
    if [ ! -f "$HOME/.config/nvim/init.lua" ]; then
        log_warn "~/.config/nvim not linked yet; run './install symlinks' first"
        return 0
    fi

    log_step "Syncing Neovim plugins (headless)"
    nvim --headless "+Lazy! sync" +qa >/dev/null 2>&1 || \
        log_warn "headless plugin sync did not complete; open nvim to finish"
}
