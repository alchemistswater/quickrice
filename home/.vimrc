" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'arcticicestudio/nord-vim'
Plug 'dylanaraps/wal.vim'

" Initialize plugin system
call plug#end()

colorscheme wal
