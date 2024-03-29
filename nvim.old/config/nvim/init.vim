set laststatus=2          " Always show the statusline
set encoding=utf-8        " Show unicode glyphs
set number relativenumber " Show relative line numbers
set ttyfast               " Optimize for fast terminal connections
set gdefault              " Add the g flag to search/replace by default
set binary                " Don't add empty newlines at end of files
set noeol                 " Don't add empty newlines at end of files
set background=dark       " Dark bg
set hlsearch              " Highlight searches
set incsearch             " Highlight dynamically as pattern is typed
set mouse=a               " Enable mouse in all modes
set noerrorbells          " Disable error bells
set nostartofline         " Don’t reset cursor to start of line when moving around.
set ruler                 " Show the cursor position
set shortmess=atI         " Don’t show the intro message when starting vim
set showmode              " Show the current mode
set title                 " Show the filename in the window titlebar
set showcmd               " Show the (partial) command as it’s being typed
syntax on                 " Enable syntax highlighting
let mapleader="\<Space>"  " Change the mapleader
set textwidth=140         " Max textwidth
set backspace=2           " Set backspace work like in most other apps
set cursorline            " Highlight the current line
set t_ut=                 " Disable Background color erase
set wildmode=longest,list " Complete longest common string, then list alternatives.
set shell=/bin/bash       " Set bash as shell

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set nolist

" Centralize backups, swapfiles and undo history
set backupdir=~/.config/nvim/backups
set directory=~/.config/nvim/swaps
if exists("&undodir")
	set undodir=~/.config/nvim/undo
endif

" Indent
set autoindent
set smartindent
set cindent

" Manage plugins
if filereadable(expand("~/.config/nvim/bundles.vim"))
	source ~/.config/nvim/bundles.vim
endif

" Use local vimrc if available {
if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif

" Remap ctrl + hjkl to move between panes
nnoremap <silent> <A-k> <C-W>k  
nnoremap <silent> <A-j> <C-W>j
nnoremap <silent> <A-h> <C-W>h
nnoremap <silent> <A-l> <C-W>l 

" Strip trailing whitespace (<leader>ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Show 'invisible' chars
map <silent> <leader>in :set invlist<CR>:set list?<CR>
" Show/hide line numbers
map <silent> <leader>nu :set invnumber<CR>:set number?<CR>
" Paste mode
nmap <silent> <leader>pa :set invpaste<CR>:set paste?<CR>
imap <silent> <leader>pa <ESC>:set invpaste<CR>:set paste?<CR>
" Make a dos2unix
map <silent> <leader>d2u :update<CR>:e ++ff=dos<CR>:setlocal ff=unix<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

"Map the arrow keys to be based on display lines, not physical lines
noremap <Down> gj
noremap <Up> gk

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" Remember previous position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
"Clean vim draw/artifacts
au BufWritePost * :silent! :syntax sync fromstart<cr>:redraw!<cr>

" Github install
let $GIT_SSL_NO_VERIFY = 'true'

" Darwincrap
let os = ""
if has("win32")
  let os="win"
else
  if has("unix")
    let s:uname = system("echo -n \"$(uname)\"")
    if s:uname == "Darwin"
      let os="mac"
    else
      let os="unix"
    endif
  endif
endif

if os == "mac"
	" Cmd+R messes up arrows
	map <Esc>[A <Up>
	map <Esc>[B <Down>
	map <Esc>[C <Right>
	map <Esc>[D <Left>
	let g:python_host_prog = '/usr/local/opt/python@2/bin/python2'
	let g:python2_host_prog = '/usr/local/opt/python@2/bin/python2'
	let g:python3_host_prog = '/usr/local/bin/python3'
endif

" Backspace madness
imap  <Left><Del>

" Long lines prob
set synmaxcol=2000
set lazyredraw " Avoid scrolling problems

" Filetype enable
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" Disable preview in autocomplete
set completeopt-=preview

if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	set encoding=utf-8
	setglobal fileencoding=utf-8
	"setglobal bomb
	set fileencodings=ucs-bom,utf-8,latin1
endif

" Neovim terminal
au TermOpen * tnoremap <Esc> <c-\><c-n>
au FileType fzf tunmap <Esc>
:tnoremap <C-h> <C-\><C-n><C-w>h
:tnoremap <C-j> <C-\><C-n><C-w>j
:tnoremap <C-k> <C-\><C-n><C-w>k
:tnoremap <C-l> <C-\><C-n><C-w>l

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set inccommand=nosplit
noremap <C-q> :confirm qall<CR>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Disable ex mode
:map Q <Nop>

" Filetypes
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab
