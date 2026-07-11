# ~/.zshrc — managed by dotfiles (do not edit in place; edit the repo).

# --- Oh My Zsh -----------------------------------------------------------
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_THEME="robbyrussell"
plugins=(git)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# --- Environment ---------------------------------------------------------
export EDITOR="nvim"
export VISUAL="nvim"

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

# --- Secrets (never versioned) -------------------------------------------
DOTFILES_SECRETS="$HOME/.config/dotfiles/secrets.zsh"
[ -f "$DOTFILES_SECRETS" ] && source "$DOTFILES_SECRETS"
