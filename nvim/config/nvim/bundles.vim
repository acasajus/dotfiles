if &compatible
	set nocompatible            " Be iMproved
endif

call plug#begin(expand('~/.config/nvim/plugins/.'))

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
	let g:make = 'make'
endif

" Completion
Plug 'Shougo/deoplete.nvim'

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
"left bar with in-file logic nav
Plug 'majutsushi/tagbar'
"Surround
Plug 'tpope/vim-surround'
"git marks in the gugter
Plug 'airblade/vim-gitgutter'

"leader cc
Plug 'scrooloose/nerdcommenter'

" Go
Plug 'fatih/vim-go'

" HTML/XML
Plug 'othree/html5.vim'

" JSX
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Status line
Plug 'bling/vim-airline'

" Easy motion
Plug 'easymotion/vim-easymotion'

" Gutentags
Plug 'ludovicchabant/vim-gutentags'

" lldb
Plug 'critiqjo/lldb.nvim'


call plug#end()

" This loads the settings of the bundles
for fpath in split(globpath('~/.config/nvim/settings', '*.vim'), '\n')
	exe 'source' fpath
endfor
