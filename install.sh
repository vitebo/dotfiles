#!/usr/bin/env bash

mv ~/.config/nvim ~/.config/nvim.old
ln -s ~/.dotfiles/nvim/ ~/.config/nvim

mv ~/.bashrc ~/.bashrc.old
ln -s ~/.dotfiles/.bashrc ~/.bashrc

mv ~/.ctags ~/.ctags.old
ln -s ~/.dotfiles/.ctags ~/.ctags

mv ~/.tmux.conf ~/.tmux.conf.old
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

mv ~/.profile ~/.profile.old
ln -s ~/.dotfiles/.profile ~/.profile

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

# install node
nvm install 10.15.1
nvm alias default 10.15.1

