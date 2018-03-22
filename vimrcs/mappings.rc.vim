" Write as root
command Ws w !sudo tee > /dev/null %

" Yank current filename and line
nmap yn :let @" = join([expand("%"), line(".")], ":")<CR>

" Search cwd for word under cursor
nmap gw :Ack <cword> -w<CR>

" Custom navigation mappings

nmap ]q :cnext<CR>
nmap [q :cprevious<CR>

nmap ,s :NERDTreeFind<CR>

nmap ,f :FufFile **/<CR>
nmap ,b :FufBuffer<CR>
nmap ,t :FufTaggedFile<CR>
nmap ,c :!ctags -f .ctags -R --extra=+f<CR><CR>:FufRenewCache<CR>
nmap ,r :FufRenewCache<CR>

nmap ;gi :YcmCompleter GoToInclude<CR>
nmap ;gc :YcmCompleter GoToDeclaration<CR>
nmap ;gf :YcmCompleter GoToDefinition<CR>
nmap ;gg :YcmCompleter GoTo<CR>
nmap ;gp :YcmCompleter GoToImprecise<CR>

nmap ;t :YcmCompleter GetType<CR>
nmap ;p :YcmCompleter GetParent<CR>
nmap ;f :YcmCompleter FixIt<CR>
nmap ;d :YcmCompleter GetDoc<CR>
nmap ;r :YcmForceCompileAndDiagnostics<CR>

" open master source latex pdf
autocmd FileType bib nmap <C-w> 0[{lv/,<CR>h"ty:silent! exec "!xdg-open /home/simon/projects/master/research/papers/<C-r>t.pdf &"<CR>
