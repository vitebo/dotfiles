# Dotfiles

## Automatic installation

```bash
$ git clone https://github.com/vitebo/dotfiles.git ~/.dotfiles

$ cd ~/.dotfiles

$ ./install.sh
```

## Manual installation

### Basic configs

- create `.bash_aliases` file
```ssh
$ touch .bash_aliases
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