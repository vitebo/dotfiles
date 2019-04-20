# Dotfiles

*ubuntu 18.04*

## Automatic installation

```bash
$ git clone https://github.com/vitebo/dotfiles.git ~/.dotfiles

$ cd ~/.dotfiles

$ ./install.sh
```

## Manual installation

### Basic configs

- update packages
  ```bash
  $ sudo apt-get update && sudo apt-get upgrade
  ```

- create `.bash_aliases` file
  ```bash
  $ touch .bash_aliases
  ```

### Git

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

  $ asdf install erlang 2.3.5

  $ asdf global erlang 2.3.5
  ```

- install elixir
  ```bash
  $ asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git

  $ asdf install elixir 1.8

  $ asdf global elixir 1.8
  ```

- install ruby
  ```bash
  $ asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

  $ asdf install ruby 2.6.3

  $ asdf global ruby 2.6.3
  ```

- install nodejs
  ```bash
  $ asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git

  $ bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

  $ asdf install nodejs 11.14.0

  $ asdf global nodejs 11.14.0
  ```

### Neovim

- install [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu)

- install *vim-plug*
  ```bash
  $ curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  $ nvim + 'PlugInstall --sync' +qa
  ```

### Sublime text

- download [sublime-text](https://www.sublimetext.com/3)

- extract file
  ```bash
  $ tar -jxvf sublime_text.tar.bz2
  ```

- move to `/opt` directory
  ```bash
  $ sudo mv sublime_text /opt/
  ```

- add desktop
  ```bash
  $ cp /opt/sublime_text/sublime_text.desktop ~/.local/share/applications/
  ```

- add alias
  ```bash
  $ echo "alias subl='/opt/sublime_text/sublime_text'" >> .bash_aliases
  ```

