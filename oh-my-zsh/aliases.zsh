# docker
alias dkc='\
  docker-compose \
  -f /home/vitebo/work/quero/docker-compose.yml \
  --env-file /home/vitebo/work/quero/.env \
'

alias dkc-run='dkc run --service-ports --use-alias --rm'

dkbash () {
  ID=$(docker ps -qf name=$1)  && docker exec -it $ID bash
}

#editor
alias nvim=~/.local/share/nvim/nvim.appimage
alias vim=~/.local/share/nvim/nvim.appimage
alias vi=~/.local/share/nvim/nvim.appimage

#k8s
alias k8s='kubectl'
