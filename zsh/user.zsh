# User configuration

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vi'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Yarn
if [ -x yarn ]; then
  PATH="$(yarn global bin):$PATH"
fi

# ngrok
# PATH=$(/home/vitebo/softwares/ngrok):$PATH
