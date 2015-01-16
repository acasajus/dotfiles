" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
	if &compatible
		set nocompatible               " Be iMproved
	endif

	" Set the runtime path
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
	let g:make = 'make'
endif


" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Interactive command execution
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'windows' : 'tools\\update-dll-mingw',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make -f make_mac.mak',
			\     'linux' : 'make',
			\     'unix' : 'gmake',
			\    },
			\ }
" Unite power!
NeoBundle 'Shougo/unite.vim'
" Neocomplete
NeoBundle 'Shougo/neocomplete.vim'
" ?
NeoBundle 'Shougo/neomru.vim'

" Status line
NeoBundle 'bling/vim-airline'

" Vim-Git
NeoBundle 'tpope/vim-fugitive'
"Syntax magic && checks
NeoBundle 'scrooloose/syntastic'
"left bar with in-file logic nav
NeoBundle 'majutsushi/tagbar'
"Surround
NeoBundle 'tpope/vim-surround'
"Yankring
NeoBundle 'vim-scripts/YankRing.vim'
"git marks in the gugter
NeoBundle 'airblade/vim-gitgutter'

"leader cc
NeoBundle 'scrooloose/nerdcommenter'

" Go
NeoBundle 'fatih/vim-go'

" Autocomplete
"NeoBundle 'Valloric/YouCompleteMe'

" Coffeescript
NeoBundle 'kchmck/vim-coffee-script'

" Match-it
NeoBundle 'tmhedberg/matchit'

call neobundle#end()


" :)
" filetype on
" filetype plugin on
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" This loads the settings of the bundles
for fpath in split(globpath('~/.vim/settings', '*.vim'), '\n')
	exe 'source' fpath
endfor

