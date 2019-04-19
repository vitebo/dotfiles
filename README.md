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