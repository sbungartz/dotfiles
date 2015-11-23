export DOTFILES=$HOME/.dotfiles

# oh-my-zsh
export ZSH=$DOTFILES/oh-my-zsh
export ZSH_CUSTOM=$DOTFILES/oh-my-zsh-custom

export ZSH_THEME="robbyrussell"

plugins=(git scala sbt)

# tmuxinator
export EDITOR='vim'

# keyboard mode
gsettings set org.gnome.desktop.input-sources current 1

# paths
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH

# language
LANG=en_US.UTF-8
LANGUAGE=en_US
LC_ALL=en_US.UTF-8


# colorscheme
export TERM=xterm-256color

# sources
source /etc/zsh_command_not_found
source $ZSH/oh-my-zsh.sh

