#!/usr/bin/env bash
#
# os.sh — operating system detection.
#
# This module only defines functions. It runs no code when loaded.

# Print the current operating system family: "macos", "linux" or "unknown".
detect_os() {
    case "$(uname -s)" in
        Darwin) echo "macos" ;;
        Linux)  echo "linux" ;;
        *)      echo "unknown" ;;
    esac
}

# Print the available Linux package manager, or nothing if none is found.
detect_package_manager() {
    if _command_exists brew; then
        echo "brew"
    elif _command_exists apt-get; then
        echo "apt"
    elif _command_exists dnf; then
        echo "dnf"
    elif _command_exists pacman; then
        echo "pacman"
    fi
}
