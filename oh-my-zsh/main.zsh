# fuzzy-finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# yarn
export PATH="$(yarn global bin):$PATH"

# ASDF
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

export PATH="$PATH:$HOME/.config/polybar/scripts"
export PATH="$HOME/.cargo/bin:$PATH"

export UID=$(id -u)
export GID=$(id -g)

alias src='source ~/.zshrc'

alias exercism='docker run \
  --name exercism \
  --rm \
  --volume="/etc/group:/etc/group:ro" \
  --volume="/etc/passwd:/etc/passwd:ro" \
  --volume="/etc/shadow:/etc/shadow:ro" \
  --volume=exercism-config:$HOME/.config/exercism \
  vitebo/exercism:v1.0.0 \
  exercism \
'

alias k8s='docker run \
  --rm \
  -it \
  -p 8080:8080 \
  --name kubectl \
  -v $HOME/.kube/config:/root/.kube/config \
  vitebo/k8s:v1.0.0 \
'

function elixir() {
  docker run --rm -it -v "$(pwd)":/usr/src/app -w /usr/src/app elixir elixir "$@"
}

function iex() {
  docker run --rm -it -v "$(pwd)":/usr/src/app -w /usr/src/app elixir iex "$@"
}

function elixirc() {
  docker run --rm -it -v "$(pwd)":/usr/src/app -w /usr/src/app elixir elixirc "$@"
}

function mix() {
  docker run --rm -it -v "$(pwd)":/usr/src/app -w /usr/src/app elixir mix "$@"
}

function dk-exec() {
  docker exec -it $(docker ps -qf name=$1) bash
}
export GTK_IM_MODULE=ibus
