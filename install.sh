#!/usr/bin/env bash

# .bashrc
mv ~/.bashrc ~/.bashrc.old
ln -s ~/.dotfiles/.bashrc ~/.bashrc

# .profile
mv ~/.profile ~/.profile.old
ln -s ~/.dotfiles/.profile ~/.profile

# neovim
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
sudo apt-get install python-dev python-pip python3-dev python3-pip
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor
mv ~/.config/nvim ~/.config/nvim.old
ln -s ~/.dotfiles/nvim/ ~/.config/nvim

# .ctags
sudo apt-get install ctags
mv ~/.ctags ~/.ctags.old
ln -s ~/.dotfiles/.ctags ~/.ctags

# tmux
sudo apt-get install tmux
mv ~/.tmux.conf ~/.tmux.conf.old
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

# nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

# node
nvm install 10.15.1
nvm alias default 10.15.1

