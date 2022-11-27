set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set clipboard+=unnamedplus
" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'sainnhe/gruvbox-material'
" dev plugins
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'hachy/eva01.vim'
call plug#end()

set termguicolors
" COLORSCHEME
colorscheme catppuccin-mocha " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
" colorscheme eva01-LCL

" REMAPS
let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
" GREP REMAP NAVIGATION
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR> 
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR> 
