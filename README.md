# Dotfiles

## Basic packages
update packages
```sh
$ sudo apt update && sudo apt upgrade
```

### Git
install git
```sh
$ add-apt-repository ppa:git-core/ppa

$ sudo apt update

$ sudo apt install git
```

## Project
clone project
```sh
$ git clone https://github.com/vitebo/dotfiles.git $HOME/.dotfiles
```

### ZSH
install zsh
```sh
$ sudo apt install zsh

$ chsh -s $(which zsh)
```

install oh-my-zsh
```sh
$ sh -c \
  "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

install plugins
```sh
$ git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
```

link files
```sh
$ ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

$ source $HOME/.zshrc
```

## Docker
install docker
```sh
$ sudo apt install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

$ sudo apt-key fingerprint 0EBFCD88

$ sudo add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable"

$ sudo apt update

$ sudo apt install docker-ce docker-ce-cli containerd.io
```

manage Docker as a non-root user
```sh
$ sudo groupadd docker

$ sudo usermod -aG docker $USER

$ newgrp docker 

$ sudo chown "$USER":"$USER" /home/"$USER"/.docker -R

$ sudo chmod g+rwx "$HOME/.docker" -R
```

install docker-compose
```sh
$ sudo curl -L \
  "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

$ sudo chmod +x /usr/local/bin/docker-compose

$ sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

## Fonts
install [jetbrains-mono](https://www.jetbrains.com/pt-pt/lp/mono/)

## ASDF
install asdf
```sh
$ git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.7.1
```

install the dependencies
```sh
$ sudo apt -y install \
  build-essential \
  autoconf \
  m4 \
  libncurses5-dev \
  libwxgtk3.0-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libpng-dev \
  libssh-dev \
  unixodbc-dev \
  xsltproc \
  fop
```

install languages
```sh
$ asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git

$ asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

$ asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

$ asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
```

move versions
```sh
$ ln -s $HOME/.dotfiles/.tool-versions $HOME/.tool-versions
```

## Neovim
install
```sh
$ sudo snap install nvim --beta --classic
```

move config
```sh
$ rm -rf $HOME/.config/nvim

$ ln -s $HOME/.dotfiles/nvim/ $HOME/.config/nvim
```

install vim-plug
```sh
$ curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

$ nvim + 'PlugInstall --sync' +qa
```

## Ag
```sh
$ sudo apt install silversearcher-ag
```

## VSCode
install
```sh
$ sudo snap install code --classic
```

link files
```sh
$ ln -s $HOME/.dotfiles/vscode/settings.json \
  $HOME/.config/Code/User/settings.json

$ ln -s $HOME/.dotfiles/vscode/keybindings.json \
  $HOME/.config/Code/User/keybindings.json
```