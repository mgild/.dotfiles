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
" Code completion
Plugin 'valloric/youcompleteme'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" Show indet level
" Plugin 'nathanaelkane/vim-indent-guides'
" Better status bar
" Plugin 'bling/vim-airline'
" let g:airline#extensions#tabline#enabled = 1
" NerdTree
Plugin 'scrooloose/nerdtree'
autocmd vimenter * NERDTree " Auto open NerdTree
autocmd vimenter * wincmd p " Cursor by default not in NerdTree
" Close vim if only NerdTree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=20 " change nerdtree default size
" Toggle NerdTree
map <C-n> :NERDTreeToggle<CR>

" Enhanced C++ highlighting
Plugin 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1

Plugin 'vim-airline/vim-airline'  " Airline line at the bottom of the screen
set laststatus=2
let g:airline_powerline_fonts = 1

Plugin 'airblade/vim-gitgutter' " Show git differences in sidebar

" Themes -----------------------
set t_Co=256 
" Set Solarized theme
" Plugin 'altercation/vim-colors-solarized'
" let g:solarized_termcolors=256
" colorscheme solarized
" set background=dark
" monokai
"Plugin 'sickill/vim-monokai'
colorscheme monokai-chris
Plugin 'flazz/vim-colorschemes'
" colorscheme molokai
" colorscheme wombat
" ------------------------------

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


syntax on " syntax based on file type
set mouse=a " allow pint and click
match Todo /\t/
set number " turn line numbers on
set cursorline " Show a line on the line the cursor is on
set wildmenu 
filetype indent on
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set clipboard=unnamed " have vim share clipboard with os
" Tabs
set expandtab " Expand tabs to spaces
set tabstop=4 " Make tabs 4 spaces
set softtabstop=4 " Make deleting an expanded tab delete 4 spaces
retab
set shiftwidth=4

" Fix backspace
set backspace=2 " makes backspace remove previous character instead of where the cursor is 

" normal copy/paste (Control Keys)
vmap <C-c> y<Esc>i
vmap <C-x> d<Esc>i
imap <C-v> <Esc>pi
imap <C-y> <Esc>ddi
map <C-z> <Esc>
imap <C-z> <Esc>ui


