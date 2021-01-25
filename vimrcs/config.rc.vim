" Enable syntax highlighting
syntax on
colorscheme default

" Adjust some highlighting colors and methods where
" the defaults produce poor contrast
highlight Search ctermbg=Gray
highlight SpellBad ctermbg=None ctermfg=Red cterm=underline
highlight Folded ctermbg=None

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Set leader key
let mapleader=","

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo

set undolevels=1000
set undoreload=10000

" Slime: Send text from vim to other tmux panes
let g:slime_target = "tmux"
let g:slime_default_config = { "socket_name": "default", "target_pane": ":.1" }
let g:slime_dont_ask_default = 1
nnoremap <C-c>c V:SlimeSend<CR>

" Ack using ag
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" FuzzyFinder
let g:fuf_enumeratingLimit = 60


" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Autoindent
set expandtab
set shiftwidth=2 softtabstop=2
autocmd FileType sshconfig setlocal sw=2 sts=2
autocmd FileType c setlocal cindent cinoptions=g0
autocmd FileType cpp setlocal cindent cinoptions=g0
autocmd FileType ruby setlocal sw=2 sts=2
autocmd FileType html setlocal sw=2 sts=2
autocmd FileType css setlocal sw=2 sts=2
autocmd FileType sass setlocal sw=2 sts=2
autocmd FileType scss setlocal sw=2 sts=2
autocmd FileType javascript setlocal sw=2 sts=2
autocmd FileType typescript setlocal sw=2 sts=2
autocmd FileType vue setlocal sw=2 sts=2
autocmd FileType coffee setlocal sw=2 sts=2
autocmd FileType yaml setlocal sw=2 sts=2
autocmd FileType markdown setlocal sw=2 sts=2
autocmd FileType julia setlocal sw=2 sts=2
autocmd FileType bib setlocal sw=2 sts=2
autocmd FileType go setlocal sw=0 tabstop=2

" Spellcheck
autocmd FileType markdown setlocal spell spelllang=de,en
autocmd FileType gitcommit setlocal spell spelllang=de,en

" Golang
" Build/Test on save.
augroup auto_go
    autocmd!
    autocmd BufWritePost *.go :GoBuild
    autocmd BufWritePost *_test.go :GoTest
augroup end

" Ruby
let g:rufo_auto_formatting = 1
let g:rufo_silence_errors = 1

" Arduino files
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp sw=2 sts=2
" Markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" YouCompleteMe
highlight YcmErrorSection ctermbg=darkblue
highlight YcmWarningSection ctermbg=darkcyan

highlight SignColumn ctermbg=black
highlight YcmErrorSign ctermbg=black ctermfg=darkred
highlight YcmWarningSign ctermbg=black ctermfg=yellow

let g:ycm_python_binary_path = 'python3.6'
let g:ycm_error_symbol = 'E' "'🚨' '☠ ' '🚫 ' '⚡ ' 
let g:ycm_warning_symbol = 'W' "'🖕' '😱 ' '⚠️ '
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_global_ycm_extra_conf = '~/.ycm_global_extra_conf.py'

" Colorscheme
if !has('gui_running')
	set t_Co=256
endif

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"✗":""}',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }
set laststatus=2

function! MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⎇ '._ : ''
  endif
  return ''
endfunction

" Allow .ctags as name for tag file
set tags+=.ctags

" Enable mouse support for [a]ll modes
set mouse=a
set ttymouse=sgr
