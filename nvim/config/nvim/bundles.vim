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
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': 'bash install.sh',
			\ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

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
Plug 'fatih/vim-hclfmt'
Plug 'b4b4r07/vim-hcl'
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

" Semantic
let g:deoplete#enable_at_startup = 2
set hidden
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loggingFile = expand('~/.config/nvim/logs/LanguageClient.log')
let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_serverStderr = expand('~/.config/nvim/logs/LanguageClient.err')
let g:LanguageClient_serverCommands = {
			\ 'rust': ['rls'],
			\ 'python': ['/usr/local/bin/pyls'],
			\ }
let g:LanguageClient_selectionUI = 'fzf'
let g:LanguageClient_settingsPath = expand('~/.config/nvim/languageclient.json')
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

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

