export DOTFILES=$HOME/.dotfiles

# oh-my-zsh
#export ZSH=$DOTFILES/oh-my-zsh
#export ZSH_CUSTOM=$DOTFILES/oh-my-zsh-custom
#
#export ZSH_THEME="robbyrussell"
#
#plugins=(git scala sbt docker)

# tmuxinator
export EDITOR='vim'

# keyboard mode
gsettings set org.gnome.desktop.input-sources current 1

# paths
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:/usr/local/bin"

export GOROOT=/opt/go
export PATH="$PATH:$GOROOT/bin"

export GOPATH=$HOME/go-work
export PATH="$PATH:$GOPATH/bin"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# language
LANG=en_US.UTF-8
LANGUAGE=en_US
LC_ALL=en_US.UTF-8

# colorscheme
export TERM=xterm-256color

# sources
source /etc/zsh_command_not_found
#source $ZSH/oh-my-zsh.sh

source $DOTFILES/antigen/antigen.zsh

