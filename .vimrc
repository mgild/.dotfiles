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

" Add tagbar
Plugin 'majutsushi/tagbar'
let g:tagbar_autoclose = 0 "keep tagbar open after selection
" autocmd vimenter * TagbarToggle " auto open tagbar

Plugin 'https://github.com/xolox/vim-misc.git' " misc
Plugin 'xolox/vim-easytags' " jump to definition (<Ctrl> + ]), + stuff
let g:easytags_async = 1 " async tag loading
nnoremap <C-]> <C-w><C-]><C-w>T
"
Plugin 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
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

" Code completion
Plugin 'valloric/youcompleteme'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/youcompleteme/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_add_preview_to_completeopt = 0
set completeopt-=preview
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" NerdTree
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs' " Add tab commands to Nerdtree
autocmd vimenter * NERDTree " Auto open NerdTree
autocmd vimenter * wincmd p " Cursor by default not in NerdTree
" let g:NERDTreeMapOpenInTabSilent = '<2-LeftMouse>'
" Close vim if only NerdTree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=15 " change nerdtree default size
let NERDTreeMapOpenInTab='<ENTER>' " press enter on nerdtree item for new tab
" let g:nerdtree_tabs_open_on_console_startup=1 " toggle nerdtree tab settings
" Toggle NerdTree

" Fast file switching
Plugin 'kien/ctrlp.vim'
let g:NERDTreeUseSimpleIndicator = 1

" General enhanced syntax highlighting
Plugin 'sheerun/vim-polyglot'
let python_highlight_all = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

Plugin 'vim-airline/vim-airline'  " Airline line at the bottom of the screen
set laststatus=2
let g:airline_powerline_fonts = 1
let g:Powerline_symbols='unicode'
let g:airline#extensions#tabline#enabled = 1

Plugin 'airblade/vim-gitgutter' " Show git differences in sidebar
Plugin 'flazz/vim-colorschemes'
Plugin 'christoomey/vim-tmux-navigator'

" Plugin 'breuckelen/vim-resize' " Better pane resizing
" let g:vim_resize_disable_auto_mappings = 1

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" General ----------------------
syntax on " syntax based on file type
set number " turn line numbers on
set cursorline " Show a line on the line the cursor is on
set wildmenu "enable extended menus
filetype indent on
set clipboard^=unnamed,unnamedplus " have vim share clipboard with os
match Todo /\t/ " add warnings over tabs
match Todo /\s\+$/ " add warnings to trailing whitespace
set colorcolumn=80
set backspace=2 " makes backspace remove previous character instead of where the cursor is
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
colorscheme Monokai
" colorscheme Benokai
" ------------------------------
" Search -----------------------
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" ------------------------------
" Tabs -------------------------
set expandtab " Expand tabs to spaces
retab
set tabstop=4 " Make tabs 4 spaces
set softtabstop=4 " Make deleting an expanded tab delete 4 spaces
set shiftwidth=4 " Make indentaion 4 spaces
" ------------------------------
" Commands ---------------------
" Sets 'S' and 'Silent' to silently exec command
command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
command! -nargs=1 S execute ':silent !'.<q-args> | execute ':redraw!'
" -----------------------------
" Pane Resizing --------------
" nmap <silent> <S-h> :CmdResizeLeft<cr>
" nmap <silent> <C-S-j> :CmdResizeDown<cr>
" nmap <silent> <C-S-k> :CmdResizeUp<cr>
" nmap <silent> <C-S-l> :CmdResizeRight<cr>
" -----------------------------
" Key Mappings -----------------
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F4> :NERDTreeToggle<CR>
"To create a new tab
nnoremap <C-t> :tabnew<Space>
inoremap <C-t> <Esc>:tabnew<Space>
"Tab Navigation
nnoremap <S-h> gT
nnoremap <S-l> gt
"Press enter to accept YCM option
" -----------------------------
