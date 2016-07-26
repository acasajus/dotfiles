" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
	if &compatible
		set nocompatible               " Be iMproved
	endif

	" Set the runtime path
	set runtimepath+=~/.config/nvim/plugins/neobundle.vim/
endif

call neobundle#begin(expand('~/.config/nvim/plugins/'))

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
	let g:make = 'make'
endif


" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Completion
NeoBundle 'Valloric/YouCompleteMe', { 'build' : { 'mac' : './install.py --clang-completer', 'unix' : './install.py --clang-completer' } }

" Buffer mamangement
NeoBundle 'jeetsukumaran/vim-buffergator'

" The silver searcher!
NeoBundle 'rking/ag.vim'

" Ctrl+P
NeoBundle 'ctrlpvim/ctrlp.vim'

" Vim-Git
NeoBundle 'tpope/vim-fugitive'
"Syntax magic && checks
NeoBundle 'scrooloose/syntastic'
"left bar with in-file logic nav
NeoBundle 'majutsushi/tagbar'
"Surround
NeoBundle 'tpope/vim-surround'
"git marks in the gugter
NeoBundle 'airblade/vim-gitgutter'

"leader cc
NeoBundle 'scrooloose/nerdcommenter'

" Go
NeoBundle 'fatih/vim-go'

" HTML/XML
NeoBundle 'othree/html5.vim'

" JSX
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'

" Status line
NeoBundle 'bling/vim-airline'

" Easy motion
NeoBundle 'easymotion/vim-easymotion'


call neobundle#end()


" :)
" filetype on
" filetype plugin on
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" This loads the settings of the bundles
for fpath in split(globpath('~/.config/nvim/settings', '*.vim'), '\n')
	exe 'source' fpath
endfor
