" -----------------------------------------------------------------------------
" General Settings 
" -----------------------------------------------------------------------------
set encoding=UTF-8
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set expandtab               " converts tabs to white space
set list
set listchars=tab:▶\ ,trail:•   " show tabs and trailing spaces
set backspace=indent,eol,start  " configure backspace to work normally
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set background=dark         " background mode
set termguicolors           " allow gui colors
"let &t_ut=''
set wildmode=longest,list   " get bash-like tab completions
set laststatus=2            "
set shell=fish              " default shell
"set spell                   " enable spell checking
set title                   "
set hidden
set signcolumn=yes:2

set number                  " add line numbers
augroup numbertoggle        " hybrid normal, absolute in insert mode
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

" -----------------------------------------------------------------------------
"  Plugins
" -----------------------------------------------------------------------------
" automatically install vim plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

" source ~/.config/nvim/plugged/airline.vim
source ~/.config/nvim/plugged/lualine.vim
source ~/.config/nvim/plugged/bufferline.vim
source ~/.config/nvim/plugged/indentblankline.vim
" source ~/.config/nvim/plugged/colorschemes.vim
source ~/.config/nvim/plugged/spacevimdark.vim
source ~/.config/nvim/plugged/commentary.vim
source ~/.config/nvim/plugged/devicons.vim
source ~/.config/nvim/plugged/fzf.vim
" source ~/.config/nvim/plugged/floaterm.vim
source ~/.config/nvim/plugged/gitsigns.vim
source ~/.config/nvim/plugged/lspconfig.vim
" source ~/.config/nvim/plugged/monokai.vim
" source ~/.config/nvim/plugged/polyglot.vim
" source ~/.config/nvim/plugged/nord.vim
source ~/.config/nvim/plugged/toggleterm.vim
source ~/.config/nvim/plugged/tree.vim
source ~/.config/nvim/plugged/treesitter.vim
source ~/.config/nvim/plugged/vimterraform.vim
source ~/.config/nvim/plugged/whichkey.vim

" Plug 'mhinz/vim-signify'
" Plug 'airblade/vim-gitgutter'

call plug#end()
doautocmd User PlugLoaded

" needed for lualine
lua << END
require('lualine').setup {
  options = {
    theme = 'dracula',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' }
  }
}
END

" needed for bufferline, should move to bufferline.vim
lua << EOF
require("bufferline").setup{}
EOF

" need for language server support
lua << EOF
require'lspconfig'.terraformls.setup{}
EOF

lua << EOF
require'lspconfig'.pyright.setup{}
EOF

lua << EOF
require'lspconfig'.rust_analyzer.setup{}
EOF

" needed for gitsigns
lua << EOF
require('gitsigns').setup()
EOF

" needed for indent blank line
lua << EOF
require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}
EOF

" needed for toggle term
lua << EOF
require("toggleterm").setup {
}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
EOF

" needed for nvim-tree
lua << EOF
require'nvim-tree'.setup()
EOF

" needed for nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" needed for which-key
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF


" -----------------------------------------------------------------------------
"  Key maps
" -----------------------------------------------------------------------------
" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Navigate buffers
map <S-l> :bnext<CR>
map <S-h> :bprevious<CR>

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'terraformls', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

