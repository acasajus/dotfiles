" Ctrl-p replacement
nnoremap <C-p> :Unite file_rec/async<cr>
" SEarch files
" Yank history
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Ctrp-p replacement
nnoremap <leader>p :<C-u>Unite -no-split -buffer-name=files  -start-insert file_rec/async:!<cr>
nnoremap <leader>g :<C-u>Unite -no-split -buffer-name=files  -start-insert file_rec/git<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files  -start-insert file<cr>
nnoremap <leader>m :<C-u>Unite -no-split -buffer-name=mru    -start-insert file_mru<cr>
" nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank   history/yank<cr>
" Buffer switch
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer buffer<cr>
" Search in files
nnoremap <leader>/ :Unite grep:.<cr> 

" Ignore .git dir
call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep',  'ignore_pattern', join([ 
      \ '\.git\/', '\.hg\/', 'Godeps\/', '\.pyc$', '\.pyo$', '\.o$', '\.class$'
      \  ], '\|'))

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
endfunction

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif