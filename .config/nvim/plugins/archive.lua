
local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

--------------------------------------------------------------------------------
-- TO REVIEW
--------------------------------------------------------------------------------
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.0' })
-- or                                , { 'branch': '0.1.x' }

Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'cossonleo/dirdiff.nvim'
Plug 'cespare/vim-toml'
Plug 'shumphrey/fugitive-gitlab.vim'

-- tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'

-- fuzzy find
Plug('junegunn/fzf', { dir='~/.fzf', ['do']= './install --all' })
Plug 'junegunn/fzf.vim'

--
Plug 'tpope/vim-dispatch'          " Kick off builds, test runs
Plug 'tpope/vim-dadbod'            " database interface
Plug 'tpope/vim-commentary'        " commenting plugin
Plug 'tpope/fugitive-gitlab.vim'
Plug 'tpope/vim-obsession'         " Session manager

-- looking
  Plug 'mhinz/vim-startify'
  Plug 'Yggdroot/indentLine'
  Plug 'ryanoasis/vim-devicons'
  Plug 'myusuf3/numbers.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ianks/gruvbox'
  Plug 'airblade/vim-gitgutter'
  Plug 'altercation/vim-colors-solarized'
-- completion/templating
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
  Plug 'jiangmiao/auto-pairs'
  Plug 'ervandew/supertab'
  Plug 'tpope/vim-endwise'
  Plug 'scrooloose/nerdcommenter'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
-- command extention
  Plug 'easymotion/vim-easymotion'
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-surround'
  Plug 'junegunn/vim-easy-align'
  Plug 'wellle/targets.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'repeat.vim'
-- utils
  Plug 'neomake/neomake'
  Plug 'kassio/neoterm'
  Plug 'sjl/gundo.vim'
  Plug 'chrisbra/NrrwRgn'
  Plug 'Mark--Karkat'
-- misc
  Plug 'asins/vimcdoc'
  Plug 'ccvext.vim'
  Plug 'CodeFalling/fcitx-vim-osx'
  Plug 'lilydjwg/fcitx.vim'
  Plug 'junegunn/vim-github-dashboard'
-- documentation
  Plug 'rhysd/nyaovim-markdown-preview'
  Plug 'xolox/vim-notes'
  Plug 'xolox/vim-misc'
  Plug 'itchyny/calendar.vim'
  Plug 'junegunn/vim-journal'
-- navigation
  Plug 'scrooloose/nerdtree'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'wesleyche/SrcExpl'
  Plug 'majutsushi/tagbar'
  Plug 'taglist.vim'
  Plug 'rizzatti/dash.vim'
  Plug 'eugen0329/vim-esearch'
-- c/c++
  Plug 'zhranklin/deoplete-clang'
-- java
  Plug 'artur-shaik/vim-javacomplete2'
  Plug 'vhakulinen/neovim-intellij-complete-deoplete'
-- python
  Plug 'zchee/deoplete-jedi'
-- html/css/javascript
  Plug 'mattn/emmet-vim'
-- scala
  Plug 'ensime/ensime-vim', { 'do': function('DoRemote') }
  Plug 'derekwyatt/vim-scala'

-- Core (treesitter, nvim-lspconfig, nvim-cmp, nvim-telescope, nvim-lualine)
 Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
 Plug 'nvim-treesitter/playground'
 Plug 'neovim/nvim-lspconfig'
 Plug 'hrsh7th/cmp-nvim-lsp'
 Plug 'hrsh7th/cmp-buffer'
 Plug 'hrsh7th/cmp-path'
 Plug 'hrsh7th/cmp-cmdline'
 Plug 'hrsh7th/nvim-cmp'
 Plug 'hrsh7th/cmp-vsnip'
 Plug 'hrsh7th/vim-vsnip'
 Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
 Plug 'nvim-lualine/lualine.nvim'
 Plug 'kyazdani42/nvim-web-devicons'
 Plug 'kyazdani42/nvim-tree.lua'
 
-- Functionalities
 Plug 'tpope/vim-fugitive'
 Plug 'tpope/vim-sensible'
 Plug 'tpope/vim-surround'
 Plug 'mhinz/vim-signify'
 Plug 'jiangmiao/auto-pairs'
 Plug 'alvan/vim-closetag'
 Plug 'tpope/vim-abolish'
 Plug 'junegunn/vim-easy-align'
 Plug 'scrooloose/nerdcommenter'
 Plug 'Yggdroot/indentLine'
 Plug 'chrisbra/Colorizer'
 Plug 'KabbAmine/vCoolor.vim'
 Plug 'dkarter/bullets.vim'
 Plug 'wellle/context.vim'
 Plug 'antoinemadec/FixCursorHold.nvim'
 
-- Functionalities - Python
 Plug 'psf/black', { 'branch': 'stable' }
 Plug 'heavenshell/vim-pydocstring'
 
-- Aesthetics - Colorschemes
 Plug 'dracula/vim', { 'as': 'dracula' }
 Plug 'zaki/zazen'
 Plug 'yuttie/hydrangea-vim'
 
-- Aesthetics - Others
 Plug 'junegunn/rainbow_parentheses.vim'
 Plug 'junegunn/limelight.vim'
 Plug 'junegunn/vim-journal'

-- Misc.
 Plug 'christoomey/vim-tmux-navigator'
 Plug 'hardcoreplayers/dashboard-nvim'
 Plug 'ap/vim-buftabline'
 
-- Feature Enhancers
 Plug 'kyazdani42/nvim-tree.lua'
 Plug 'sbernheim4/vim-ripgrep'
 Plug 'mhinz/vim-signify'
 Plug 'ruanyl/vim-gh-line'
 Plug 'rhysd/git-messenger.vim'
 
-- Text Manipulation
 Plug 'Raimondi/delimitMate'
 Plug 'tpope/vim-surround'
 Plug 'AndrewRadev/sideways.vim'
 Plug 'FooSoft/vim-argwrap'
 
-- Syntax highlighting
 Plug 'nvim-treesitter/nvim-treesitter'
 Plug 'gruvbox-community/gruvbox'
 
-- LSP
 Plug 'williamboman/nvim-lsp-installer'
 Plug 'neovim/nvim-lspconfig'
 Plug 'nvim-lua/popup.nvim'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'ojroques/nvim-lspfuzzy'
 Plug 'ray-x/lsp_signature.nvim'
 
-- Snippets and Completion
 Plug 'hrsh7th/nvim-cmp'
 Plug 'hrsh7th/cmp-nvim-lsp'
 Plug 'hrsh7th/cmp-buffer'
 Plug 'hrsh7th/cmp-nvim-lua'
 Plug 'hrsh7th/vim-vsnip'
 Plug 'hrsh7th/vim-vsnip-integ'
 
-- Plug 'simrat39/symbols-outline.nvim'
 Plug 'mxsdev/symbols-outline.nvim', { 'branch': 'folding' }
 
-- For linting/formatting via ESLint and Prettier
 Plug 'dense-analysis/ale'

--------------------------------------------------------------------------------
-- REVIEWED
--------------------------------------------------------------------------------
-- :J: Needs to support more than two veritical buffers
-- :J: Plug 'kyazdani42/nvim-tree.lua'

vim.call('plug#end')


--------------------------------------------------------------------------------
-- Configuration
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- REVIEWED
--------------------------------------------------------------------------------
-- nvim-tree setup _____________________________________________________________
-- empty setup using defaults
--require("nvim-tree").setup()
-- OR setup with some options
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
    git = {
        enable = true,
        ignore = false,
        timeout = 400,
    },
}) 

