#!/usr/bin/env bash
#
# packages.sh — installation of required system packages.
#
# This module only defines functions. It runs no code when loaded.

# Core packages the environment depends on. Kept as a function-local list so
# the module has no top-level state.
_core_packages() {
    printf '%s\n' git zsh neovim curl
}

install_packages() {
    local os
    os="$(detect_os)"

    case "$os" in
        macos) _install_macos_packages ;;
        linux) _install_linux_packages ;;
        *)
            log_error "Unsupported operating system for package installation"
            return 1
            ;;
    esac

    # Tools that are not reliably packaged across distros are handled on their
    # own, after the core packages (and their prerequisites like curl) exist.
    _install_uv
}

# uv (Astral) — required by the Neovim toolchain (Mason). Not consistently
# available in apt/dnf, so prefer Homebrew and fall back to the official
# standalone installer. INSTALLER_NO_MODIFY_PATH keeps it from editing shell
# profiles; PATH is managed by our own .zshrc instead.
_install_uv() {
    if _command_exists uv; then
        log_info "already installed: uv"
        return 0
    fi

    log_step "Installing uv"
    if _command_exists brew; then
        brew install uv
    else
        curl -LsSf https://astral.sh/uv/install.sh | INSTALLER_NO_MODIFY_PATH=1 sh
    fi
}

# --- macOS ---------------------------------------------------------------
_install_macos_packages() {
    _install_homebrew

    local pkg
    while IFS= read -r pkg; do
        if brew list --formula "$pkg" >/dev/null 2>&1; then
            log_info "already installed: $pkg"
        else
            log_step "Installing $pkg"
            brew install "$pkg"
        fi
    done < <(_core_packages)
}

_install_homebrew() {
    if _command_exists brew; then
        log_info "Homebrew already installed"
        return 0
    fi
    log_step "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# --- Linux ---------------------------------------------------------------
_install_linux_packages() {
    local manager
    manager="$(detect_package_manager)"

    case "$manager" in
        apt)    _install_apt ;;
        dnf)    _install_dnf ;;
        pacman) _install_pacman ;;
        brew)   _install_macos_packages ;;  # Homebrew on Linux
        *)
            log_error "No supported package manager found (apt, dnf, pacman)"
            return 1
            ;;
    esac
}

_install_apt() {
    log_step "Updating apt package index"
    _sudo apt-get update -y

    local pkg
    while IFS= read -r pkg; do
        if dpkg -s "$pkg" >/dev/null 2>&1; then
            log_info "already installed: $pkg"
        else
            log_step "Installing $pkg"
            _sudo apt-get install -y "$pkg"
        fi
    done < <(_core_packages)
}

_install_dnf() {
    local pkg
    while IFS= read -r pkg; do
        if rpm -q "$pkg" >/dev/null 2>&1; then
            log_info "already installed: $pkg"
        else
            log_step "Installing $pkg"
            _sudo dnf install -y "$pkg"
        fi
    done < <(_core_packages)
}

_install_pacman() {
    local pkg
    while IFS= read -r pkg; do
        if pacman -Qi "$pkg" >/dev/null 2>&1; then
            log_info "already installed: $pkg"
        else
            log_step "Installing $pkg"
            _sudo pacman -S --noconfirm "$pkg"
        fi
    done < <(_core_packages)
}
