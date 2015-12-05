"
" User: A00000
" File: .vimrc
"
" Enable filetype plugins
filetype plugin on
filetype indent on

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Enable syntax highlighting
syntax on

" Set to auto read when a file is changed from the outside
set autoread

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

set bg=dark "background

" Set off the other paren
highlight MatchParen ctermbg=4
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=1
set ruler
"set incsearch
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
set mouse=a

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Edit vimrc ,ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

colorscheme jellybeans

set colorcolumn=81

map <leader>t :NERDTreeToggle<CR>
let NERTTreeIgnore=["*.o"]
let NERDTreeAutoDeleteBuffer=1



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

"-------------------------------------------------------------------------------
" FOLDING
"-------------------------------------------------------------------------------
"set foldmethod=syntax
"map <F4> :execute "grep -rn " . expand("<cword>") . " **"<CR>:cw<CR><CR>
" Show whitespace
"set list listchars=tab:»·,trail:·
"set lispwords+=type-case,define-type,module+,local,if
"map <F4> :bp<bar>sp<bar>bn<bar>bd<CR>
"map <F4> :execute "grep -rn " . expand("<cword>") . " **"<CR>:cw<CR><CR>
" Show whitespace
"set list listchars=tab:»·,trail:·
"execute pathogen#infect()
"highlight comment ctermfg=green
"hi LineNr ctermfg=darkblue
"set foldmethod=syntax
" Fast saving
"nmap <leader>w :w<cr>
"map <leader>q :wq<cr>
" Useful mappings for managing tabs
"map <leader>tn :tabnew<cr>
"map <leader>to :tabonly<cr>
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
"nmap <M-j> mz:m+<cr>`z
"nmap <M-k> mz:m-2<cr>`z
"vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
"vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
"map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
