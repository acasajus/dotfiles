
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
Bundle 'fholgado/minibufexpl.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'sjl/gundo.vim'
Bundle 'majutsushi/tagbar'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'tpope/vim-sleuth'

" Ruby/rails
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'


" :)
filetype on
filetype plugin indent on
