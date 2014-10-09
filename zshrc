export DOTFILES=$HOME/.dotfiles

# oh-my-zsh
export ZSH=$DOTFILES/oh-my-zsh
export ZSH_CUSTOM=$DOTFILES/oh-my-zsh-custom

export ZSH_THEME="robbyrussell"

plugins=(git scala sbt)

# paths
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH

# language
LANG=en_US.UTF-8
LANGUAGE=en_US

# sources
source $ZSH/oh-my-zsh.sh

