
" Set filetype on -> off to prevent some versions of vim to explode
filetype on
filetype off

" Set the runtime path
set rtp+=~/.vim/bundle/vundle

" Init Vundle
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Plugin time!
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'sjl/gundo.vim'
Bundle 'majutsushi/tagbar'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'ciaranm/detectindent'
Bundle 'airblade/vim-gitgutter'
" Proper formating of *ml
Bundle 'tpope/vim-ragtag'
" leader cc
Bundle 'scrooloose/nerdcommenter'
" session management
Bundle 'tpope/vim-obsession'

" Ruby/rails
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'kchmck/vim-coffee-script'


" :)
filetype on
filetype plugin on
filetype plugin indent on
