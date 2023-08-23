
set nocompatible

source $HOME/.config/vim/vimrc.vim

"______________________________PLUGINS______________________________"
call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
"Plug 'tpope/vim-dispatch'          " Kick off builds, test runs
"Plug 'tpope/vim-dadbod'            " database interface
"Plug 'tpope/vim-commentary'        " commenting plugin
"Plug 'tpope/fugitive-gitlab.vim'
"Plug 'tpope/vim-obsession'         " Session manager

Plug 'cespare/vim-toml'
Plug 'shumphrey/fugitive-gitlab.vim'
" 

call plug#end()


autocmd FileType go set noexpandtab
