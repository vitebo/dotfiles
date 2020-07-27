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
alias ohmyzsh='vi $HOME.dotfiles/oh-my-zsh'
alias dotfiles='vi $HOME/.dotfiles'

function deploy-homolog() {
  git branch -D homolog
  git switch -c homolog
  git push origin homolog --force
  git switch -
}

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh