map <C-e> :NERDTreeTabsToggle<CR>

let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git$', '\.hg', '\.svn', '\.bzr', '\.DS_Store$', 'node_modules', '\.tmp']

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeWinSize = 30

let NERDTreeMapOpenSplit = 's'
let NERDTreeMapOpenVSplit = 'v'

" call g:NERDTreeAddMenuItem({
"     \ 'text': 'archiv(e) the current note file',
"     \ 'shortcut': 'e',
"     \ 'callback': 'MyNERDTreeArchiveNote'
"     \ })

autocmd FileType nerdtree nmap ,a :call MyNERDTreeArchiveNote()<CR>

function! MyNERDTreeArchiveNote()
  let curNode = g:NERDTreeFileNode.GetSelected()
  let curPath = curNode.path.str()
  let newPath = substitute(curPath, '^/home/simon/Meins/Notizen/', '/home/simon/Meins/Notizen/Archiv/' . strftime('%Y') . '/', '')

  if filereadable(newPath)
    call nerdtree#echoWarning('This destination already exists. Aborted.')
    return
  endif

  try
      if curNode.path.isDirectory
          let l:curPath = escape(curNode.path.str(),'\') . (nerdtree#runningWindows()?'\\':'/') . '.*'
          let l:openBuffers = filter(range(1,bufnr('$')),'bufexists(v:val) && fnamemodify(bufname(v:val),":p") =~# "'.escape(l:curPath,'\').'"')
      else
          let l:openBuffers = filter(range(1,bufnr('$')),'bufexists(v:val) && fnamemodify(bufname(v:val),":p") ==# curNode.path.str()')
      endif

      call curNode.rename(newPath)
      " Emptying g:NERDTreeOldSortOrder forces the sort to
      " recalculate the cached sortKey so nodes sort correctly.
      let g:NERDTreeOldSortOrder = []
      call b:NERDTree.root.refresh()
      call NERDTreeRender()

      " If the file node is open, or files under the directory node are
      " open, ask the user if they want to replace the file(s) with the
      " renamed files.
      if !empty(l:openBuffers)
          if curNode.path.isDirectory
              echo "\nDirectory renamed.\n\nFiles with the old directory name are open in buffers " . join(l:openBuffers, ', ') . '. Replace these buffers with the new files? (yN)'
          else
              echo "\nFile renamed.\n\nThe old file is open in buffer " . l:openBuffers[0] . '. Replace this buffer with the new file? (yN)'
          endif
          if g:NERDTreeAutoDeleteBuffer || nr2char(getchar()) ==# 'y'
              for bufNum in l:openBuffers
                  call s:renameBuffer(bufNum, newPath, curNode.path.isDirectory)
              endfor
          endif
      endif

      call curNode.putCursorHere(1, 0)

      redraw!
  catch /^NERDTree/
      call nerdtree#echoWarning('Node Not Renamed.')
  endtry
endfunction
