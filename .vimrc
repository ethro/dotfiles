"
" User: A00000
" File: .vimrc
"
" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax on

" Set to auto read when a file is changed from the outside
"set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Ignore files
set wildignore=*.o,*~,*.pyc,*.swp

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" No annoying sound on errors
set noerrorbells
set novisualbell

set bg=dark

set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
set ruler
set incsearch
set smartcase
set smarttab
set expandtab
set tabstop=3
set softtabstop=3
set shiftwidth=3
set smartindent
set autoindent
set number
set cmdheight=1
set nowrap
" Enable mouse support in console

set colorcolumn=80

colorscheme jellybeans
if has("gui_running")
   "set fullscreen
   set transparency=10
endif

set shiftround " sr
set cindent " cin
set copyindent " ci
set preserveindent "pi

"set wildignorecase
set wildmenu
"set lisp " enable lisp mode
" Show whitespace
"set list listchars=tab:»·,trail:·
"set lispwords+=type-case,define-type,module+,local,if

" Edit vimrc ,ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

