# Dotfiles

## Basic packages

- update packages
  ```bash
  $ sudo apt-get update && sudo apt-get upgrade
  ```

- install curl
  ```bash
  $ sudo apt install curl
  ```

### Git

- install git
  ```bash
  $ sudo apt-get install git
  ```

- config git
  ```bash
  $ git config --global user.name "vitebo"
  $ git config --global user.email "vitebo@hotmail.com"
  $ git config --global core.editor vi
  ```

## Project

- clone project
  ```bash
  $ git clone https://github.com/vitebo/dotfiles.git ~/.dotfiles
  ```

## Basic configs

- create config files
  ```bash
  $ mv ~/.bash_aliases ~/.bash_aliases.old
  $ ln -s ~/.dotfiles/.bash_aliases ~/.bash_aliases

  $ mv ~/.bashrc ~/.bashrc.old
  $ ln -s ~/.dotfiles/.bashrc ~/.bashrc
  $ source ~/.bashrc

  $ mv ~/.profile ~/.profile.old
  $ ln -s ~/.dotfiles/.profile ~/.profile
  $ source ~/.profile
  ```

## Docker

- install [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

## Fonts

- install [nerd-fonts](https://github.com/ryanoasis/nerd-fonts#option-3-install-script)

## Tmux

- install tmux
  ```bash
  $ sudo apt-get install tmux
  ```

- use *dotfiles* settings
  ```bash
  $ ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
  ```

- add reset script
  ```bash
  $ curl -Lo ~/.tmux/reset --create-dirs \
      https://raw.githubusercontent.com/hallazzang/tmux-reset/master/tmux-reset
  ```

- add plugins manager
  ```bash
  $ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```

- install plugins
  ```bash
  $ ~/.tmux/plugins/tpm/bin/install_plugins
  ```

- copy from tmux buffer to system buffer (clipboard)
  ```bash
  sudo apt-get install --assume-yes xclip
  ```

## ASDF

- install asdf
  ```bash
  $ git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.1
  ```

- install the dependencies
  ```bash
  $ sudo apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop
  ```

- install erlang
  ```bash
  $ asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
  ```

- install elixir
  ```bash
  $ asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  ```

- install ruby
  ```bash
  $ asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
  ```

- install nodejs
  ```bash
  $ asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

  $ bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

  $ npm install -g yarn
  ```

- move versions
  ```bash
  $ ln -s ~/.dotfiles/.tool-versions ~/.tool-versions
  ```

## Neovim

- install [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu)
  ```bash
  $ sudo apt-get install neovim
  ```

- set default editor
  ```bash
  $ sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
  $ sudo update-alternatives --config vi
  $ sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
  $ sudo update-alternatives --config vim
  $ sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
  $ sudo update-alternatives --config editor
  $ sudo rm /usr/bin/vim && sudo ln -s /usr/bin/nvim /usr/bin/vim
  ```

- move config
  ```bash
  $ ln -s ~/.dotfiles/nvim/ ~/.config/nvim
  ```

- install *vim-plug*
  ```bash
  $ curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  $ nvim + 'PlugInstall --sync' +qa
  ```

## Ag
  ```bash
  $ sudo apt-get install silversearcher-ag
  ```

## Ctags
  ```bash
  $ sudo apt-get install ctags
  $ mv ~/.ctags ~/.ctags.old
  $ ln -s ~/.dotfiles/.ctags ~/.ctags
  ```

## Oh my bash
  ```bash
  $ git clone git://github.com/ohmybash/oh-my-bash.git ~/.oh-my-bash
  $ rm -rf ~/.oh-my-bash/custom/
  $ ln -s ~/.dotfiles/oh-my-bash/custom ~/.oh-my-bash/
  ```

