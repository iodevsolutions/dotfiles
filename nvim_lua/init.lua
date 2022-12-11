vim.opt.number = true
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  --- Color
  --use 'maxmx03/FluoroMachine.nvim'
  --vim.cmd [[colorscheme fluoromachine]]
  --use 'TroyFletcher/vim-colors-synthwave'
  --vim.cmd[[colorscheme synthwave]]
  use 'rebelot/kanagawa.nvim'
  vim.cmd[[colorscheme kanagawa]]

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "lua", "rust", "python" },
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },
  }
  -- Lualine
  use 'nvim-lualine/lualine.nvim'
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto'  -- fluoromachine auto
    }
  }
  -- fzf
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
end)
vim.opt.termguicolors = true
-- vim.opt.background = dark 
vim.opt.list = true
vim.opt.listchars:append('tab:> ')
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.swapfile = false
vim.opt.wrap = false
-- Map global leader for \ to Space
vim.g.mapleader = ' '
-- Open recently used files
vim.api.nvim_set_keymap('n', '<leader>fr', ':History<CR>', {noremap = true})
-- Open files in same directory as current file
vim.api.nvim_set_keymap('n', '<leader>ff', ':e %:h/<C-d>', {noremap = true})
