" This is moslty the vimrc for vundle setup taken from
" https://github.com/gmarik/Vundle.vim.
" The actual plugin loading is sourced from $DOTFILES/vimrcs/plugins.vim.
" After the vundle plugin setup all *.rc.vim files in $DOTFILES/vimrcs will be
" sourced, so any actual configuration is placed in this directory.

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Now source the .dotfiles/vimrcs/plugins.vim file where all plugins will be added:
source $DOTFILES/vimrcs/plugins.vim

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"Now source the actual configuration from the vimrcs directory:
for f in split(globpath('$DOTFILES/vimrcs', '*.rc.vim'), '\n')
  exe 'source' f
endfor
