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

# Disable Software Flow Control in tty driver, so accidental Ctrl+S does not freeze terminal
stty -ixon

# paths
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:/usr/local/bin"

export GOROOT=/opt/go
export PATH="$PATH:$GOROOT/bin"

export GOPATH=$HOME/go-work
export PATH="$PATH:$GOPATH/bin"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# python virtualenv
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# language
LANG=en_US.UTF-8
LANGUAGE=en_US
LC_ALL=en_US.UTF-8

# colorscheme
export TERM=xterm-256color

setopt HIST_IGNORE_SPACE

########### ANTIGEN ################
# Static bundle loading from cookbook (https://github.com/zsh-users/antigen/wiki/Cookbook#static-bundle-loading)
# Needed for performance until v2 becomes stable...
#
# Seems not to work with wd since env var $ZSH is not set. Always load slowly for now...

# If there is cache available
#if [[ -f ${ADOT:-$HOME/.antigen}/.cache/.zcache-payload ]]; then
#    # Load bundles statically
#    source ${ADOT:-$HOME/.antigen}/.cache/.zcache-payload
#
#    # You will need to call compinit
#    autoload -Uz compinit
#    compinit -d ${HOME}/.zcompdump
#else
    # If there is no cache available do load and execute antigen
    source $DOTFILES/antigen/antigen.zsh
    
    # Load the oh-my-zsh's library.
    antigen use oh-my-zsh
    
    # Bundles from the default repo (robbyrussell's oh-my-zsh).
    antigen bundle command-not-found
    antigen bundle wd
    
    antigen bundle git
    #antigen bundle scala
    #antigen bundle sbt

#    antigen bundle zsh-users/zsh-completions
    
    # Syntax highlighting bundle.
    #antigen bundle zsh-users/zsh-syntax-highlighting
    
    # Custom scripts to be sourced from this repo
    antigen bundle "$DOTFILES/local-bundle" --no-local-clone
    
    # Load the theme.
    antigen theme robbyrussell
    
    # Tell antigen that you're done.
    antigen apply
#fi
