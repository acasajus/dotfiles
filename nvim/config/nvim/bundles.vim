if &compatible
	set nocompatible            " Be iMproved
endif

call plug#begin(expand('~/.config/nvim/plugins/.'))

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
	let g:make = 'make'
endif

" Completion
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Buffer mamangement
Plug 'jeetsukumaran/vim-buffergator'

" The silver searcher!
Plug 'rking/ag.vim'

" Ctrl+P
Plug 'ctrlpvim/ctrlp.vim'

" Vim-Git
Plug 'tpope/vim-fugitive'
"Syntax magic && checks
Plug 'neomake/neomake'

"Surround
Plug 'tpope/vim-surround'
"git marks in the gugter
Plug 'airblade/vim-gitgutter'

"leader cc
Plug 'scrooloose/nerdcommenter'

" Go (included in Polyglot)
" Plug 'zchee/deoplete-go'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" HTML/XML (Polyglot)
Plug 'othree/html5.vim'

" JS
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" typescript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

" Dart
Plug 'dart-lang/dart-vim-plugin'

" lsc
Plug 'natebosch/vim-lsc'

" Status line
Plug 'bling/vim-airline'

" Easy motion
Plug 'easymotion/vim-easymotion'

" Gutentags
" Plug 'ludovicchabant/vim-gutentags'

" lldb
" Plug 'critiqjo/lldb.nvim'

" Nerdtree
Plug 'scrooloose/nerdtree'

" Colorschemes
" Plug 'tomasr/molokai'

call plug#end()

"Ag
nnoremap <leader>/ :Ag<space>

" Airline
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#quickfix#quickfix_text = 'Quickfix'
let g:airline#extensions#quickfix#location_text = 'Location'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#powerline#fonts = 0
let g:airline#theme = 'badwolf'

" Buffergator
let g:buffergator_viewport_split_policy="B"
let g:buffergator_sort_regime="mru"

" CtrlP
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\.git$\|\.hg$\|\.svn$|coverage|tmp|vendor$',
	\ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
	\ }
let g:ctrlp_extensions = ['cmdline', 'yankring', 'undo']
let g:ctrlp_user_command = {
	\ 'types': {
		\ 1: ['.git', 'cd %s && git ls-files'],
		\ 2: ['.hg', 'hg --cwd %s locate -I .'],
		\ },
	\ 'fallback': 'find %s -type f'
	\ }
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlP'

" Deoplete
" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('ignore_sources', {'_': ['*.vue', 'buffer', '*.dart']})

" Go
let g:go_disable_autoinstall = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_fmt_command = "goimports"

" Dart
let dart_format_on_save = 1
let dart_style_guide = 2

" Neomake
nnoremap <leader>m :Neomake<CR> 
let g:neomake_cpp_enable_makers = ['clang']
let g:neomake_cpp_clang_args = ["-std=c++11", "-Wextra", "-Wall", "-fsanitize=undefined","-g","-I/usr/local/Cellar/boost/1.58.0/include","-I/usr/local/include/","-stdlib=libc++"]
"Open the window automatically when Neomake is run, but without moving your cursor
let g:neomake_open_list = 2
"autocmd! BufWritePost,BufEnter * Neomake
let g:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe=substitute(g:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

" LSC
let g:lsc_enable_autocomplete = v:true
let g:lsc_server_commands = {
	\ 'dart': 'dart_language_server',
	\ 'go': 'go-langserver -gocodecompletion -maxparallelism 5 -mode stdio -lint-tool golint',
	\ 'vue': 'vls',
	\ 'javascript': 'javascript-typescript-stdio'
	\ }
let g:lsc_auto_map = {
    \ 'GoToDefinition': '<C-]>',
    \ 'FindReferences': 'gr',
    \ 'NextReference': '<C-n>',
    \ 'PreviousReference': '<C-p>',
    \ 'FindImplementations': 'gI',
    \ 'FindCodeActions': 'ga',
    \ 'DocumentSymbol': 'go',
    \ 'WorkspaceSymbol': 'gS',
    \ 'ShowHover': 'K',
    \ 'Completion': 'completefunc',
    \}
