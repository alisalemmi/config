call plug#begin('~/.local/share/nvim/plugins')
" editor
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-commentary'
Plug 'windwp/nvim-autopairs'

" syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'

" file explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" tabs
Plug 'akinsho/nvim-bufferline.lua'
Plug 'famiu/bufdelete.nvim'

" status line
Plug 'hoob3rt/lualine.nvim'

" git
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

call plug#end()

source /etc/xdg/nvim/plugins/tree.lua
source /etc/xdg/nvim/plugins/bufferLine.lua
source /etc/xdg/nvim/plugins/lualine.lua
source /etc/xdg/nvim/plugins/autopairs.lua
source /etc/xdg/nvim/plugins/gitsign.lua

source /etc/xdg/nvim/plugins/indentLine.vim
