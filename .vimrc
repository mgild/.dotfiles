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
" Syntax checker
Plugin 'w0rp/ale'
let g:airline#extensions#ale#enabled = 1
let g:ale_cpp_gcc_executable = '-std=c++14 -Wall -lssl -lcrypto'
let g:ale_python_flake8_executable = 'python'
let g:ale_python_flake8_options = '-m flake8 --ignore=E201,E202,E203,E225,E231,E302,E303,E501'
" let g:ale_lint_on_text_changed = 'never'

" Code completion
Plugin 'honza/vim-snippets'
Plugin 'lifepillar/vim-mucomplete'
set completeopt+=menuone
inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
inoremap <expr> <cr> mucomplete#popup_exit("\<cr>")
""set completeopt+=noselect
set completeopt+=noinsert
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
let g:mucomplete#enable_auto_at_startup = 1
set noshowmode shortmess+=c
set completeopt-=preview
set completeopt+=longest,menuone,noinsert,noselect
let g:mucomplete#user_mappings = { 'sqla' : "\<c-c>a" }
let g:mucomplete#chains = { 'sql' : ['file', 'sqla', 'keyn'] }
let g:jedi#popup_on_dot = 0  " It may be 1 as well
set noinfercase
" The following line assumes `brew install llvm` in macOS
let g:clang_library_path = '/usr/local/opt/llvm/lib/libclang.dylib'
let g:clang_user_options = '-std=c++14'
let g:clang_complete_auto = 1
let g:mucomplete#chains.default = ['c-n', 'omni', 'dict', 'file']
let g:mucomplete#enable_auto_at_startup = 1
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Fast file switching
Plugin 'kien/ctrlp.vim'

" General enhanced syntax highlighting
Plugin 'sheerun/vim-polyglot'
let python_highlight_all = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
autocmd BufNewFile,BufRead *.epy   set syntax=htmldjango

Plugin 'vim-airline/vim-airline'  " Airline line at the bottom of the screen
set laststatus=2
let g:airline_powerline_fonts = 1
let g:Powerline_symbols='unicode'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

Plugin 'airblade/vim-gitgutter' " Show git differences in sidebar
Plugin 'flazz/vim-colorschemes'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-surround'
Plugin 'DoxygenToolkit.vim'
let g:DoxygenToolkit_briefTag_pre="@Brief "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns "
let g:DoxygenToolkit_authorName="Mitch Gildenberg"
" Plugin 'breuckelen/vim-resize' " Better pane resizing
" let g:vim_resize_disable_auto_mappings = 1


" Django support
Plugin 'lambdalisue/vim-django-support'


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
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h13 " Force set gui font
set t_Co=256
let g:solarized_termcolors=256
colorscheme Monokai
" "colorscheme solarized
hi TabLineFill ctermfg=DarkGrey
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
command! Vsrc execute 'source ~/.vimrc'
" Auto-Commands ---------------------
" Detect file changes and offer reload
au FocusGained,CursorHold,BufEnter * checktime
" -----------------------------
" Pane Resizing --------------
" nmap <silent> <S-h> :CmdResizeLeft<cr>
" nmap <silent> <C-S-j> :CmdResizeDown<cr>
" nmap <silent> <C-S-k> :CmdResizeUp<cr>
" nmap <silent> <C-S-l> :CmdResizeRight<cr>
" -----------------------------
" Key Mappings -----------------
nnoremap <F8> :TagbarToggle<CR>
"Buffer Navigation
noremap <C-n> :bnext<CR>
noremap <C-b> :bprevious<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
" -----------------------------

" Overrides
" -----------------------------
" mini insert (single char)
noremap m i <Esc>r
" -----------------------------
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END
