set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

set nocompatible
filetype plugin indent on
syntax on
let g:ycm_show_diagnostics_ui = 0

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'https://github.com/xolox/vim-misc.git' " misc
"
Plugin 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Plugin 'luochen1990/rainbow'
let g:rainbow_active = 1

" Syntax checker
Plugin 'w0rp/ale'
let g:ale_linters = {
\   'cpp': ['gcc'],
\}
" if you don't want linters to run on opening a file
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1

let g:ale_cpp_ccls_options=$VIM_CPP_FLAGS
let g:ale_cpp_clang_options=$VIM_CPP_FLAGS
let g:ale_cpp_clangcheck_options=$VIM_CPP_FLAGS
let g:ale_cpp_clangd_options=$VIM_CPP_FLAGS
let g:ale_cpp_clangtidy_options=$VIM_CPP_FLAGS
let g:ale_cpp_clazy_options=$VIM_CPP_FLAGS
let g:ale_cpp_cppcheck_options=$VIM_CPP_FLAGS
let g:ale_cpp_cpplint_options=$VIM_CPP_FLAGS
let g:ale_cpp_cquery_options=$VIM_CPP_FLAGS
let g:ale_cpp_flawfinder_options=$VIM_CPP_FLAGS
let g:ale_cpp_gcc_options=$VIM_CPP_FLAGS

" Lint only on save
" let g:ale_lint_on_text_changed = 'never'
let g:airline#extensions#ale#enabled = 1
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = '-m flake8 --ignore=E201,E202,E203,E225,E231,E302,E303,E501'
" let g:ale_lint_on_text_changed = 'never'
"
" Plugin 'lifepillar/vim-mucomplete'
Plugin 'valloric/youcompleteme'
let g:ycm_show_diagnostics_ui = 0
set completeopt-=preview
let g:ycm_global_ycm_extra_conf = '/usr/local/google/home/mgild/.vim/bundle/youcompleteme/third_party/ycmd/.ycm_extra_conf.py'

" inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
" inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
set belloff+=ctrlg " If Vim beeps during completion
let g:mucomplete#enable_auto_at_startup = 1
set noshowmode shortmess+=c
" set completeopt=menu,menuone,noinsert,noselect,longest
set completeopt+=menuone,noselect
let g:UltiSnipsUsePythonVersion='3'
let g:UltiSnipsExpandTrigger="<C-w>"
let g:UltiSnipsJumpForwardTrigger="<C-w>"
let g:UltiSnipsJumpBackwardTrigger="<C-q>"
let g:mucomplete#chains = {
\   'default' : ['incl', 'c-n', 'omni', 'user', 'dict', 'file', 'ulti', 'tags']
\}
let g:jedi#popup_on_dot = 0
set noinfercase
let g:clang_library_path = '$HOME/chromiumos/chroot/usr/lib64/libclang.so.7.0'
let g:clang_user_options = '-std=c++14'
let g:clang_complete_auto = 1
" General enhanced syntax highlighting
Plugin 'sheerun/vim-polyglot'
autocmd BufEnter *.\(gyp\|gypi\|gn\) :set syntax=python
" autocmd BufEnter *.conf :set syntax=xml
" Plugin 'octol/vim-cpp-enhanced-highlight'
let python_highlight_all = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

Plugin 'patstockwell/vim-monokai-tasty'

Plugin 'vim-airline/vim-airline'  " Airline line at the bottom of the screen
set laststatus=2
let g:airline_powerline_fonts = 1
let g:Powerline_symbols='unicode'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Plugin 'airblade/vim-gitgutter' " Show git differences in sidebar
Plugin 'mhinz/vim-signify' " VCS gutter (works with git and g4)
Plugin 'flazz/vim-colorschemes'
Plugin 'ervandew/supertab'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
map <C-p> :FZF<CR>
Plugin 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" only highlight curr scope
Plugin 'scrooloose/nerdtree'
let g:NERDTreeNodeDelimiter = "\u00a0"
noremap <C-E> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
autocmd VimEnter * NERDTreeToggle "Open nerdtree on start
autocmd vimenter * wincmd p " Cursor by default not in NerdTree
let g:NERDTreeWinSize=20 " change nerdtree default size
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

" General ----------------------
syntax on " syntax based on file type
set number " turn line numbers on
set autoread " auto reload on foreign changes to files
set noeb vb t_vb= " disable bell
set cursorline " Show a line on the line the cursor is on
set wildmenu " enable extended menus
filetype indent on
set clipboard^=unnamed,unnamedplus " have vim share clipboard with os
set list
set listchars=tab:\ \  " highlight tabs
match Todo /\s\+$/ " highlight trailing spaces
set colorcolumn=80
set backspace=2 " makes backspace remove previous character instead of where the cursor is
set mouse=a " allow point and click UI
" Don't conceal characters. Applicable for quote hiding in json files
autocmd bufenter * set conceallevel=0
" Mouse fix for tmux
if &term =~ '^screen'
" tmux knows the extended mouse mode
set ttymouse=xterm2
endif
" ------------------------------
" Themes -----------------------
colorscheme Monokai
" let g:vim_monokai_tasty_italic = 1
" colorscheme vim-monokai-tasty
" ------------------------------
" Search -----------------------
set incsearch  " search as characters are entered
set hlsearch   " highlight matches
" set ignorecase " ignore case on search
" ------------------------------
" Tabs -------------------------
retab
set expandtab     " Expand tabs to spaces
set tabstop=4     " Make tabs 4 spaces
set softtabstop=4 " Make deleting a tab delete 4 spaces
set shiftwidth=4  " Make indentaion 4 spaces
" ------------------------------
" Auto-Commands ---------------------
au FocusGained,CursorHold,CursorHoldI,BufEnter * checktime
" jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" -----------------------------
" Key Mappings -----------------
" copy the current text selection to the system clipboard
" if has('gui_running') || has('nvim') && exists('$DISPLAY')
  " noremap <Leader>y "+y
" else
  " " copy to attached terminal using the yank(1) script:
  " noremap <silent> <Leader>y y:call system('yank > /dev/tty', @0)<Return>
" endif
"Buffer Navigation
noremap <C-n> :bnext<CR>
noremap <C-b> :bprevious<CR>
" Modify scroll actions
" :map <ScrollWheelUp>     5<Down>
" :map <ScrollWheelDown>   5<Up>
" -----------------------------
" Set indentation to 2 spaces for C++
au BufRead,BufNewFile *.cc,*.h setl sw=2 sts=2 ts=2 et

" Close buffer without closing split
command! BD sb # | bd #
