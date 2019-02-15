#!/usr/bin/env bash

mv ~/.config/nvim ~/.config/nvim.old
ln -s ~/.dotfiles/nvim/ ~/.config/nvim

mv ~/.bashrc ~/.bashrc.old
ln -s ~/.dotfiles/.bashrc ~/.bashrc

mv ~/.ctags ~/.ctags.old
ln -s ~/.dotfiles/.ctags ~/.ctags

mv ~/.tmux.conf ~/.tmux.conf.old
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

