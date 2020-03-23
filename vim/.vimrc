call plug#begin('~/.vim/plugged')

" Full path fuzzy find
Plug 'ctrlpvim/ctrlp.vim'

" Dev Icons (Works with CtrlP and Nerdtree)
"Plug 'ryanoasis/vim-devicons'

Plug 'flazz/vim-colorschemes'
Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'

" Nerdtree specific
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'ctrlpvim/ctrlp.vim'

" Powerline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Python Specific
Plug 'sheerun/vim-polyglot'                         " syntax highlighting
Plug 'Vimjas/vim-python-pep8-indent'                " indentation
Plug 'dense-analysis/ale'                           " linting
"Plug 'neoclide/coc.nvim', {'branch': 'release'}     " code completion / language server

call plug#end()

set encoding=UTF-8          
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results

set backspace=indent,eol,start  " configure backspace to work normally
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed

set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set laststatus=2            " 
set shell=sh

filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting

colorscheme space-vim-dark

" Nerdtree configuration
map <C-n> :NERDTreeToggle<CR> 
vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" powerline fonts enable
let g:airline_powerline_fonts = 1

" different separators for airline (extra-powerline-symbols):
"let g:airline_left_sep = "\uE0C6"
"let g:airline_right_sep = "\uE0C7"

" ale notifications in airline.
let g:airline#extensions#ale#enabled = 1

" set the CN (column number) symbol:
"let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . "\uE0A3" . '%{col(".")}'])

" Python Relate stuff
let g:python_highlight_all = 1

" Folding for Python
au BufNewFile,BufRead *.py
  \ set foldmethod=indent
nnoremap <space> za

" Ale linters
let b:ale_linters = {
    \   'python': ['flake8', 'pylint'],
\}

" coc configuration
nmap <silent> gd <Plug>(coc-definition)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

nmap <leader>rn <Plug>(coc-rename)
