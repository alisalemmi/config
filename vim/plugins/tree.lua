vim.g.nvim_tree_git_hl = 0
vim.g.nvim_tree_highlight_opened_files = 0
vim.g.nvim_tree_indent_markers = 1

vim.g.nvim_tree_show_icons = {
  git = 1,
  files = 1,
  folders = 1,
  folder_arrows = 1
}

vim.g.nvim_tree_icons = { 
  default = '',
  git     = {
    unstaged = '',
    staged = '',
    unmerged = '',
    renamed = '',
    untracked = '',
    deleted = '',
    ignored = ''
  },
  folder = {
    arrow_open = '',
    arrow_closed = '',
    default = '',
    open = '',
    empty = '',
    empty_open = '',
    symlink = '',
    symlink_open = '',
  }
}

require('nvim-tree').setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = true,
  ignore_ft_on_setup  = {},
  auto_close          = true,
  auto_open           = true,
  open_on_tab         = true,
  hijack_cursor       = true,
  update_cwd          = true,
  update_to_buf_dir   = {
    enable    = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons  = {
      hint    = "",
      info    = "כֿ",
      warning = "",
      error   = "✗",
    }
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom   = { '.git', 'node_modules', '.cashe', 'dist' }
  },
  git = {
    enable  = true,
    ignore  = true,
    timeout = 500,
  },
  view = {
    width            = 30,
    height           = 30,
    hide_root_folder = false,
    side             = 'left',
    auto_resize      = true,
    mappings = {
      custom_only = false,
      list        = {}
    },
    number         = false,
    relativenumber = false,
    signcolumn     = 'yes'
  },
  trash = {
    cmd = 'trash',
    require_confirm = true
  }
}
