#!/usr/bin/make
export

setup:
	$(MAKE) add-repositories
	sudo apt update
	sudo apt upgrade
	$(MAKE) apt-install
	$(MAKE) install-snap-packages
	$(MAKE) setup-zsh
	$(MAKE) setup-fuzzy-finder
	$(MAKE) setup-docker
	$(MAKE) setup-asdf
	$(MAKE) setup-neovim

add-repositories:
	add-apt-repository ppa:git-core/ppa

apt-install:
	sudo apt install -y \
		apt-transport-https \
		autoconf \
		build-essential \
		ca-certificates \
		curl \
		fop \
		git \
		gnupg \
		htop \
		libgl1-mesa-dev \
		libglu1-mesa-dev \
		libncurses5-dev \
		libpng-dev \
		libssh-dev \
		libwxgtk3.0-dev \
		lsb-release \
		m4 \
		silversearcher-ag \
		silversearcher-ag \
		snapd \
		unixodbc-dev \
		xclip \
		xsltproc \
		zsh

install-snap-packages:
	sudo snap install nvim --beta --classic
	sudo snap install spotify
	sudo snap install slack --classic
	sudo snap install universal-ctags

setup-zsh:
	chsh -s $(which zsh)
	sh -c \
		"$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions \
		${ZSH_CUSTOM}/plugins/zsh-autosuggestions
	ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
	source $HOME/.zshrc

setup-fuzzy-finder:
	git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
	$HOME/.fzf/install

setup-docker:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
		sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	echo \
  	"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  	$(lsb_release -cs) stable" | \
		sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt install docker-ce docker-ce-cli containerd.io
	sudo groupadd docker
	sudo usermod -aG docker $USER
	newgrp docker 
	sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
	sudo chmod g+rwx "$HOME/.docker" -R
	sudo systemctl enable docker.service
	sudo systemctl enable containerd.service
	sudo curl -L \
		"https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
		-o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

setup-asdf:
	git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.7.1
	asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
	asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
	asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
	asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	ln -s $HOME/.dotfiles/.tool-versions $HOME/.tool-versions
	asdf install

setup-neovim:
	ln -s $HOME/.dotfiles/nvim/ $HOME/.config/nvim
	curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim + 'PlugInstall --sync' +qa
