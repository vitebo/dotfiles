# Dotfiles

*ubuntu 18.04*

## Automatic installation

```bash
$ git clone https://github.com/vitebo/dotfiles.git ~/.dotfiles

$ cd ~/.dotfiles

$ ./install.sh
```

## Manual installation

### Basic packages

- update packages
  ```bash
  $ sudo apt-get update && sudo apt-get upgrade
  ```

- install curl
  ```bash
  $ sudo apt install curl
  ```

#### Git

- install git
  ```bash
  $ sudo apt-get install git
  ```

- config git
  ```bash
  $ git config --global user.name "username"
  $ git config --global user.email "email"
  $ git config --global core.editor vi
  ```

### Project

- clone project
  ```bash
  $ git clone https://github.com/vitebo/dotfiles.git ~/.dotfiles
  ```

### Basic configs

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

### Docker

- install [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

### Fonts

- install [nerd-fonts](https://github.com/ryanoasis/nerd-fonts#option-3-install-script)

- install [powerline](https://powerline.readthedocs.io/en/master/installation.html#generic-requirements)

### Tmux

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

### ASDF

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

  $ asdf install erlang <VERSION>

  $ asdf global erlang <VERSION>
  ```

- install elixir
  ```bash
  $ asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

  $ asdf install elixir <VERSION>

  $ asdf global elixir <VERSION>
  ```

- install ruby
  ```bash
  $ asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

  $ asdf install ruby <VERSION>

  $ asdf global ruby <VERSION>
  ```

- install nodejs
  ```bash
  $ asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

  $ bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

  $ asdf install nodejs <VERSION>

  $ asdf global nodejs <VERSION>

  $ npm install -g yarn
  ```

### Neovim

- install [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu)

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
