# fuzzy-finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export ANDROID_HOME=/home/vitebo/android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:~/android-studio/bin

alias src='source ~/.zshrc'

alias gnome-control-center='XDG_CURRENT_DESKTOP=GNOME gnome-control-center'

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

function deploy-homolog() {
  git branch -D homolog
  git switch -c homolog
  git push origin homolog --force
  git switch -
}

function dk-exec() {
  docker exec -it $(docker ps -qf name=$1) bash
}
export GTK_IM_MODULE=ibus

# yarn
export PATH="$(yarn global bin):$PATH"

neofetch
