filetype on
filetype indent on
filetype plugin on

syntax on

set clipboard=unnamedplus
set encoding=utf-8
set ft=unix
set fileencoding=utf-8
set mouse=a
set re=0
set shell=/bin/zsh
set shiftwidth=2
set spell spelllang=en_us
set statusline=%F%m%r%h%w%=\ [%Y]\ [%{&ff}]\ [%04l,%04v]\ [%p%%]\ [%L]
set tabstop=2
set wildmode=longest,list

set autoindent
set hlsearch
set incsearch
set nobackup
set nocompatible
set noshowmode
set noswapfile
set nowrap
set number
set ruler
set showmatch
set smartcase
set smartindent
set ttyfast
set wildmenu

call plug#begin('~/.vim/plugged')
	Plug 'rakr/vim-one'
	Plug 'scrooloose/nerdtree'
	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()

colorscheme one
set background=light

autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif
