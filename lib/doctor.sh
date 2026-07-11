#!/usr/bin/env bash
#
# doctor.sh — validate the environment and report inconsistencies.
#
# This module only defines functions. It runs no code when loaded.

run_doctor() {
    log_step "Running environment diagnostics"

    local failures=0

    _doctor_os || failures=$((failures + 1))
    _doctor_commands || failures=$((failures + 1))
    _doctor_ohmyzsh || failures=$((failures + 1))
    _doctor_symlinks || failures=$((failures + 1))
    _doctor_secrets || failures=$((failures + 1))

    if [ "$failures" -eq 0 ]; then
        log_success "Everything looks healthy"
    else
        log_warn "$failures check(s) reported issues"
        return 1
    fi
}

_doctor_os() {
    local os
    os="$(detect_os)"
    if [ "$os" = "unknown" ]; then
        log_error "operating system: unknown"
        return 1
    fi
    log_success "operating system: $os"
}

_doctor_commands() {
    local ok=0 cmd
    for cmd in git zsh nvim curl; do
        if _command_exists "$cmd"; then
            log_success "command available: $cmd"
        else
            log_error "command missing: $cmd"
            ok=1
        fi
    done
    return "$ok"
}

_doctor_ohmyzsh() {
    if [ -d "${ZSH:-$HOME/.oh-my-zsh}" ]; then
        log_success "Oh My Zsh installed"
    else
        log_error "Oh My Zsh not installed"
        return 1
    fi
}

# Verify that every managed entry resolves to a symlink pointing back into
# the repository.
_doctor_symlinks() {
    local ok=0
    _doctor_symlink_tree "$DOTFILES_HOME" "$HOME" || ok=1
    _doctor_symlink_tree "$DOTFILES_CONFIG" "$HOME/.config" || ok=1
    return "$ok"
}

_doctor_symlink_tree() {
    local src_dir="$1" dest_dir="$2" status=0

    [ -d "$src_dir" ] || return 0

    local entry name dest
    shopt -s nullglob dotglob
    for entry in "$src_dir"/*; do
        name="$(basename "$entry")"
        dest="$dest_dir/$name"
        if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$entry" ]; then
            log_success "linked: ${dest/#$HOME/~}"
        else
            log_error "not linked: ${dest/#$HOME/~}"
            status=1
        fi
    done
    shopt -u nullglob dotglob
    return "$status"
}

_doctor_secrets() {
    if [ -f "$HOME/.config/dotfiles/secrets.zsh" ]; then
        log_success "secrets file present"
    else
        log_warn "secrets file not set up (run './install secrets')"
    fi
}
