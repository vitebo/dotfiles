# configure keyboard
# setxkbmap -model pc104 -layout us_intl

alias src='source $HOME/.zshrc'

alias dkc='\
  docker-compose \
  -f $HOME/work/quero/docker-compose.yml \
  --env-file $HOME/work/quero/.env \
'

alias dkc-run='dkc run --service-ports --use-alias --rm'

alias vi='nvim'
alias vim='nvim'

alias zshconfig='vi $HOME/.zshrc'
alias dotfiles='vi $HOME/.dotfiles'
alias awsconfig='vi $HOME/.aws/config'
alias kconfig='vi $HOME/.kube/b2b-homolog.yml'

function deploy-homolog() {
  git branch -D homolog
  git switch -c homolog
  git push origin homolog --force
  git switch -
}

function git-reset-hard() {
  git add .
  git reset --hard HEAD
}

# FZF
export FZF_BASE=$HOME/.fzf

# Yarn
export PATH="$(yarn global bin):$PATH"
