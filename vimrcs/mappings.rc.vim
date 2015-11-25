"nnoremap <C-i> :r!xclip -o<CR>

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
