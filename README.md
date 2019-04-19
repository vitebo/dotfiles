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
