#!/usr/bin/env bash
#
# Entry point for the dotfiles bootstrap.
#
# Responsibilities (and nothing more):
#   * configure the bootstrap environment
#   * discover the repository root
#   * load every module from lib/
#   * interpret the requested task
#   * dispatch to the matching functions
#
# All business logic lives in lib/. This file only wires things together.

set -Eeuo pipefail

# --- Repository root discovery -------------------------------------------
# Resolve the real location of this script, following symlinks, so the
# bootstrap works no matter where it is invoked from.
_resolve_root() {
    local source="${BASH_SOURCE[0]}"
    while [ -h "$source" ]; do
        local dir
        dir="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"
        source="$(readlink "$source")"
        [[ $source != /* ]] && source="$dir/$source"
    done
    cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd
}

# --- Global paths (only the entry point defines these) -------------------
DOTFILES_ROOT="$(_resolve_root)"
DOTFILES_LIB="$DOTFILES_ROOT/lib"
DOTFILES_HOME="$DOTFILES_ROOT/home"
DOTFILES_CONFIG="$DOTFILES_ROOT/config"
export DOTFILES_ROOT DOTFILES_LIB DOTFILES_HOME DOTFILES_CONFIG

# --- Module loading ------------------------------------------------------
# Modules only export functions; loading them has no side effects.
_load_modules() {
    local module
    for module in common os packages symlinks ohmyzsh secrets doctor; do
        # shellcheck source=/dev/null
        source "$DOTFILES_LIB/$module.sh"
    done
}

usage() {
    cat <<'EOF'
Usage: ./install [task]

Tasks:
  (none)     Run the full installation
  packages   Install required system packages
  symlinks   Create configuration symlinks
  secrets    Prepare the local secrets directory
  ohmyzsh    Install Oh My Zsh
  doctor     Validate the environment and report inconsistencies
  help       Show this message
EOF
}

# Full installation, run when no task is provided.
_task_all() {
    log_step "Bootstrapping dotfiles ($(detect_os))"
    install_packages
    create_symlinks
    setup_secrets
    install_ohmyzsh
    log_success "Bootstrap complete"
}

main() {
    _load_modules

    local task="${1:-all}"
    case "$task" in
        all)      _task_all ;;
        packages) install_packages ;;
        symlinks) create_symlinks ;;
        secrets)  setup_secrets ;;
        ohmyzsh)  install_ohmyzsh ;;
        doctor)   run_doctor ;;
        help | -h | --help) usage ;;
        *)
            log_error "Unknown task: $task"
            usage
            exit 1
            ;;
    esac
}

main "$@"
