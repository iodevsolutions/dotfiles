vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  --use 'rebelot/kanagawa.nvim'
  use 'folke/tokyonight.nvim'
  use {
    'ray-x/starry.nvim', 
    setup = function() 
      vim.g.starry_italic_comments = true
      vim.g.starry_set_hl = true
    end
  }

  use 'hashivim/vim-terraform'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use 'nvim-lualine/lualine.nvim'
  use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use {'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = 'nvim-lua/plenary.nvim'}
  use 'lewis6991/gitsigns.nvim'
  use 'numToStr/Comment.nvim'

  -- Color
  --vim.cmd[[colorscheme kanagawa]]
  vim.cmd[[colorscheme tokyonight]]
  require("tokyonight").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "storm"
  })
  --vim.cmd[[colorscheme dracula]]

  -- Treesitter
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "vim", "help", "dockerfile", "hcl", "python", "rust" },
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },
  }

  -- Lualine
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'tokyonight'  -- fluoromachine auto
    }
  }

  -- Bufferline
  require("bufferline").setup{}

  -- Gitsigns
  require('gitsigns').setup()

  -- Comment
  require('Comment').setup()
 
end)

vim.opt.number = true
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
vim.opt.mouse = 'a'

-- Map global leader from \ to Space
vim.g.mapleader = ' '
-- Allow gf to open non-existent files
vim.api.nvim_set_keymap('n', 'gf', ':edit <cfile><cr>', {noremap = true})
-- Navigate buffers
vim.api.nvim_set_keymap('n', '<S-l>', ':bnext<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-h>', ':bprevious<CR>', {noremap = true})
-- Open recently used files
vim.api.nvim_set_keymap('n', '<leader>fr', ':History<CR>', {noremap = true})
-- Open files in same directory as current file
vim.api.nvim_set_keymap('n', '<leader>ff', ':e %:h/<C-d>', {noremap = true})
-- Yank to system clipboard 
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = true})
-- Paste from system clipboard
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', {noremap = true})
-- Replace while in visual mode
vim.api.nvim_set_keymap('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>', {noremap = true})
-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

