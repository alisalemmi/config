"""""""""""""""""""""""""""""""
"       silly configs ;)      "
"""""""""""""""""""""""""""""""
syntax on

set fileformat=unix
set encoding=UTF-8

"""""""""""""""""""""""""""""""
"            editor           "
"""""""""""""""""""""""""""""""

" theme
colorscheme dracula

set mouse=a
set signcolumn=yes:1
set number
set cursorline
set nowrap

" scroll margin
set scrolloff=5
set sidescrolloff=7

" split editor
set splitbelow
set splitright

" better support
set termguicolors
set termbidi

" hide ~ at empty lines
set fillchars=fold:\ ,vert:\|,eob:\ ,msgsep:‾

" spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smartindent
set autoindent
set smarttab
set expandtab

" search
set ignorecase
set smartcase
set incsearch
set hlsearch

"""""""""""""""""""""""""""""""
"         command box         "
"""""""""""""""""""""""""""""""
set showcmd
set cmdheight=1
set noshowmode

"""""""""""""""""""""""""""""""
"           utility           "
"""""""""""""""""""""""""""""""
set undodir=~/.vim/undodir
set undofile
set nobackup
set clipboard=unnamed
