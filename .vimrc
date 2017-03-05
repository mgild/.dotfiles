set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

Plugin 'https://github.com/xolox/vim-misc.git' " misc
" Plugin 'xolox/vim-easytags' " jump to definition (<Ctrl> + ]), + stuff
" let g:easytags_async = 1 " async tag loading
Plugin 'tpope/vim-commentary' " comment multiple lines

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}
" Syntax checker
Plugin 'scrooloose/syntastic'
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = '-std=c++14'
let g:syntastic_python_flake8_exec = '/usr/bin/python2'

" Enhanced Python Highlighting
Plugin 'git@github.com:hdima/python-syntax.git'
let python_highlight_all = 1

" Code completion
Plugin 'valloric/youcompleteme'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
" NerdTree
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs' " Add tab commands to Nerdtree
autocmd vimenter * NERDTree " Auto open NerdTree
autocmd vimenter * wincmd p " Cursor by default not in NerdTree
" let g:NERDTreeMapOpenInTabSilent = '<2-LeftMouse>'
let g:NERDTreeUseSimpleIndicator = 1
" Close vim if only NerdTree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=15 " change nerdtree default size
let g:nerdtree_tabs_open_on_console_startup=1 " toggle nerdtree tab settings
" Toggle NerdTree
map <C-f> :NERDTreeToggle<CR>

" Enhanced C++ highlighting
Plugin 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1

Plugin 'vim-airline/vim-airline'  " Airline line at the bottom of the screen
set laststatus=2
let g:airline_powerline_fonts = 1
let g:Powerline_symbols='unicode'

Plugin 'airblade/vim-gitgutter' " Show git differences in sidebar

Plugin 'flazz/vim-colorschemes'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" General ----------------------  
syntax on " syntax based on file type
set number " turn line numbers on
set cursorline " Show a line on the line the cursor is on
set wildmenu  " Enhanced command completion
filetype indent on
set clipboard^=unnamed,unnamedplus " have vim share clipboard with os
match Todo /\t/ " add warnings over tabs
set mouse=a " allow point and click UI
" Mouse fix for tmux
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif
" ------------------------------
" Themes -----------------------
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline " Force set gui font
set t_Co=256
colorscheme monokai-chris
" ------------------------------
" Search -----------------------
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" ------------------------------
" Tabs ------------------------- 
set expandtab " Expand tabs to spaces
set tabstop=4 " Make tabs 4 spaces
set softtabstop=4 " Make deleting an expanded tab delete 4 spaces
retab
set shiftwidth=4
set backspace=2 " makes backspace remove previous character instead of where the cursor is
" ------------------------------
" Commands --------------------- 
" Sets 'S' and 'Silent' to silently exec command
command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
command! -nargs=1 S execute ':silent !'.<q-args> | execute ':redraw!'
" -----------------------------
