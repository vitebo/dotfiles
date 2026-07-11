#!/usr/bin/env bash
#
# packages.sh — installation of required system packages.
#
# This module only defines functions. It runs no code when loaded.

# Core packages the environment depends on. Kept as a function-local list so
# the module has no top-level state. Neovim is intentionally NOT here: distro
# packages (notably apt) ship versions too old for NvChad (needs >= 0.11 /
# vim.uv needs >= 0.10), so it is handled by _install_neovim instead.
_core_packages() {
    printf '%s\n' git zsh curl
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
    _install_neovim
    _install_uv
}

# --- Neovim --------------------------------------------------------------
# NvChad requires a recent Neovim (>= 0.11); vim.uv (used by init.lua) needs
# >= 0.10. Distro packages are often older, so prefer Homebrew and otherwise
# install the official stable release into ~/.local.
_install_neovim() {
    if _nvim_is_recent; then
        log_info "neovim already present and recent enough"
        return 0
    fi

    if _command_exists brew; then
        log_step "Installing neovim (Homebrew)"
        brew install neovim
        return 0
    fi

    _install_neovim_release
}

# True when nvim exists and reports version >= 0.10.
_nvim_is_recent() {
    _command_exists nvim || return 1
    local ver major minor
    ver="$(nvim --version 2>/dev/null | head -1 | grep -oE '[0-9]+\.[0-9]+' | head -1)"
    [ -n "$ver" ] || return 1
    major="${ver%%.*}"
    minor="${ver#*.}"
    [ "$major" -gt 0 ] || [ "$minor" -ge 10 ]
}

_install_neovim_release() {
    local arch
    case "$(uname -m)" in
        x86_64 | amd64)  arch="x86_64" ;;
        aarch64 | arm64) arch="arm64" ;;
        *)
            log_error "Unsupported architecture for Neovim release: $(uname -m)"
            return 1
            ;;
    esac

    local asset="nvim-linux-${arch}"
    local url="https://github.com/neovim/neovim/releases/download/stable/${asset}.tar.gz"
    local dest="$HOME/.local"
    local tmp
    tmp="$(mktemp -d)"

    log_step "Installing Neovim stable release (${arch})"
    curl -fsSL "$url" -o "$tmp/nvim.tar.gz"
    tar -xzf "$tmp/nvim.tar.gz" -C "$tmp"

    mkdir -p "$dest/bin"
    rm -rf "$dest/nvim"
    mv "$tmp/$asset" "$dest/nvim"
    ln -sf "$dest/nvim/bin/nvim" "$dest/bin/nvim"
    rm -rf "$tmp"

    log_success "Neovim installed to $dest/nvim (linked into ~/.local/bin)"
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
