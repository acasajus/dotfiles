if &compatible
	set nocompatible               " Be iMproved
endif

" Set the runtime path
set runtimepath+=~/.config/nvim/plugins/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.config/nvim/plugins/.'))

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
	let g:make = 'make'
endif

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Completion
call dein#add('Shougo/neocomplete.vim')

" Buffer mamangement
call dein#add('jeetsukumaran/vim-buffergator')

" The silver searcher!
call dein#add('rking/ag.vim')

" Ctrl+P
call dein#add('ctrlpvim/ctrlp.vim')

" Vim-Git
call dein#add('tpope/vim-fugitive')
"Syntax magic && checks
call dein#add('neomake/neomake')
"left bar with in-file logic nav
call dein#add('majutsushi/tagbar')
"Surround
call dein#add('tpope/vim-surround')
"git marks in the gugter
call dein#add('airblade/vim-gitgutter')

"leader cc
call dein#add('scrooloose/nerdcommenter')

" Go
call dein#add('fatih/vim-go')

" HTML/XML
call dein#add('othree/html5.vim')

" JSX
call dein#add('pangloss/vim-javascript')
call dein#add('mxw/vim-jsx')

" Status line
call dein#add('bling/vim-airline')

" Easy motion
call dein#add('easymotion/vim-easymotion')


call dein#end()


" :)
" filetype on
" filetype plugin on
filetype plugin indent on
syntax enable

" This loads the settings of the bundles
for fpath in split(globpath('~/.config/nvim/settings', '*.vim'), '\n')
	exe 'source' fpath
endfor
