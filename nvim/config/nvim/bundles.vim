if &compatible
	set nocompatible            " Be iMproved
endif

call plug#begin(expand('~/.config/nvim/plugged'))

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
	let g:make = 'make'
endif


" Vim enhancements
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'

" GUI
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'
Plug 'airblade/vim-gitgutter'

" Semantic language
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language support
Plug 'fatih/vim-go'
Plug 'othree/html5.vim'
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'HerringtonDarkholme/yats.vim'
Plug 'rust-lang/rust.vim'

call plug#end()


" Airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#powerline#fonts = 0
let g:airline#theme = 'badwolf'

" rooter
let g:rooter_patterns = ['Rakefile', 'Cargo.toml', '.git/']

" fzf
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_buffers_jump = 1

if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	nnoremap <leader>/ :Ag<space>
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
	nnoremap <leader>/ :Rg<space>
endif 
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>gf :GFiles<CR>

" Go
let g:go_disable_autoinstall = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_fmt_command = "goimports"

" Rust
let g:rustfmt_autosave = 1

" Dart
let dart_format_on_save = 1
let dart_style_guide = 2

" Semantic

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>


