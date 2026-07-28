# ~/.zshrc — managed by dotfiles (do not edit in place; edit the repo).

# --- Oh My Zsh -----------------------------------------------------------
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_THEME="robbyrussell"
plugins=(git)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# --- Environment ---------------------------------------------------------
export EDITOR="nvim"
export VISUAL="nvim"

# User-local binaries (uv, pipx, ...).
export PATH="$HOME/.local/bin:$PATH"

# Inside a Dev Container `devup` mounts a persistent volume at /dotfiles-cache;
# send XDG data (Neovim plugins, Mason tools) there so they survive container
# recreation. The directory only exists in that container, so this is a no-op
# on a normal host.
[ -d /dotfiles-cache ] && export XDG_DATA_HOME="/dotfiles-cache/share"

# Homebrew (macOS / Linuxbrew) if present.
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# --- Aliases -------------------------------------------------------------
alias vim="nvim"
alias ll="ls -lah"
alias gs="git status"
alias gl="git log --oneline --graph --decorate"

# --- Dev Containers ------------------------------------------------------
# Helpers (devup, devexec, devlogs, devstatus, devstop, devrm) that locate the
# container by its devcontainer.local_folder label, not by its name.
DOTFILES_DEVCONTAINER="$HOME/.config/zsh/devcontainer.zsh"
[ -f "$DOTFILES_DEVCONTAINER" ] && source "$DOTFILES_DEVCONTAINER"

# --- Secrets (never versioned) -------------------------------------------
DOTFILES_SECRETS="$HOME/.config/zsh/secrets.zsh"
[ -f "$DOTFILES_SECRETS" ] && source "$DOTFILES_SECRETS"
