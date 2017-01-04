" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Slime: Send text from vim to other tmux panes
let g:slime_target = "tmux"
nnoremap <C-c>c V:SlimeSend<CR>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Autoindent
set expandtab
set shiftwidth=4 softtabstop=4
autocmd FileType cpp setlocal cindent cinoptions=g0
autocmd FileType html setlocal sw=2 sts=2
autocmd FileType css setlocal sw=2 sts=2
autocmd FileType javascript setlocal sw=2 sts=2
autocmd FileType yaml setlocal sw=2 sts=2
autocmd FileType markdown setlocal sw=2 sts=2
autocmd FileType julia setlocal sw=2 sts=2

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

let g:ycm_error_symbol = '🚨 ' "'☠ ' '🚫 ' '⚡ ' 
let g:ycm_warning_symbol =  '🖕' "'😱 ' '⚠️ '
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
