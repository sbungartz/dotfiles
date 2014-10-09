export DOTFILES=$HOME/.dotfiles

# oh-my-zsh
export ZSH=$DOTFILES/oh-my-zsh
export ZSH_CUSTOM=$DOTFILES/oh-my-zsh-custom

export ZSH_THEME="robbyrussell"

plugins=(git scala sbt)

# paths
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH

# sources
source $ZSH/oh-my-zsh.sh

