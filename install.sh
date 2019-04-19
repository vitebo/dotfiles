#!/usr/bin/env bash

# require nerd-fonts

# updata packages
sudo apt-get update
sudo apt-get upgrade

# curl
sudo apt install curl

# powerline
sudo apt-get install powerline fonts-powerline
mkdir -p ~/bin/powerline
git clone https://github.com/powerline/powerline.git ~/bin/powerline/
sudo wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf -O /usr/share/fonts/PowerlineSymbols.otf
sudo wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf -O /etc/fonts/conf.d/10-powerline-symbols.conf
ln -s ~/.dotfiles/powerline/ ~/.config/

# .bashrc
mv ~/.bashrc ~/.bashrc.old
ln -s ~/.dotfiles/.bashrc ~/.bashrc
source ~/.bashrc

# .profile
mv ~/.profile ~/.profile.old
ln -s ~/.dotfiles/.profile ~/.profile
source ~/.profile

# neovim
alias vim=nvim
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
sudo rm /usr/bin/vim && sudo ln -s /usr/bin/nvim /usr/bin/vim
mv ~/.config/nvim ~/.config/nvim.old
ln -s ~/.dotfiles/nvim/ ~/.config/nvim

# ag
sudo apt-get install silversearcher-ag

# vim-plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim + 'PlugInstall --sync' +qa

# .ctags
sudo apt-get install ctags
mv ~/.ctags ~/.ctags.old
ln -s ~/.dotfiles/.ctags ~/.ctags

# tmux
sudo apt-get install tmux
mv ~/.tmux.conf ~/.tmux.conf.old
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
curl -Lo ~/.tmux/reset --create-dirs \
    https://raw.githubusercontent.com/hallazzang/tmux-reset/master/tmux-reset
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
source-file ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins

#asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.0

# nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

# node
nvm install 10.15.1
nvm alias default 10.15.1

# yarn
sudo apt-get install --no-install-recommends yarn
