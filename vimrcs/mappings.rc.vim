"nnoremap <C-i> :r!xclip -o<CR>

nmap ,f :FufFile **/<CR>
nmap ,b :FufBuffer<CR>
nmap ,t :FufTaggedFile<CR>
nmap ,c :!ctags -f .ctags -R --extra=+f<CR><CR>:FufRenewCache<CR>
nmap ,r :FufRenewCache<CR>

