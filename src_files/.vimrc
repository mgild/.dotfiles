set nocompatible
source /usr/share/vim/google/google.vim
filetype plugin indent on
syntax on
source /usr/share/vim/google/glug/bootstrap.vim
Glug google-csimporter
" Glug youcompleteme-google
" Glug glug sources+=/google/src/files/head/depot/google3/experimental/users/rahm
" Glug radiation-release

set nocompatible              " be iMproved, required
filetype off                  " required
" set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin("~/.vim/plugged")
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
" let g:lsc_auto_map = v:true
" Send async completion requests.
" WARNING: Might interfere with other completion plugins.
let g:lsp_async_completion = 1

" Enable UI for diagnostics
let g:lsp_diagnostics_enabled = 1
let g:lsp_highlights_enabled = 1
let g:lsp_textprop_enabled = 1
let g:lsp_highlight_references_enabled = 1
let g:lsp_signs_enabled = 1           " enable diagnostics signs in the gutter
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

" Enabling fuzzy completion
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1
" au User lsp_setup call lsp#register_server({
      " \ 'name': 'Kythe Language Server',
      " \ 'cmd': {server_info->['/google/bin/releases/grok/tools/kythe_languageserver', '--google3']},
      " \ 'whitelist': ['python', 'go', 'java', 'cpp', 'proto'],
      " \})
au User lsp_setup call lsp#register_server({
      \ 'name': 'CiderLSP',
      \ 'cmd': {server_info->[
      \   '/google/bin/releases/editor-devtools/ciderlsp',
      \   '--tooltag=vim-lsp',
      \   '--noforward_sync_responses',
      \   '-hub_addr=blade:languageservices-staging',
      \ ]},
      \ 'whitelist': ['c', 'cpp', 'java', 'proto', 'textproto', 'go'],
      \})
" set completeopt=noselect,menuone,preview
" set completeopt+=longest
nnoremap gd :<C-u>LspDefinition<CR>
nnoremap <leader>rr :LspReferences<CR>
" ------------------------------
" NerdTree ---------------------
Plug 'scrooloose/nerdtree'
nnoremap <leader>ff :NERDTreeFocus<cr>
let g:NERDTreeNodeDelimiter = "\u00a0"
nnoremap <C-E> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']
" autocmd VimEnter * NERDTreeToggle "Open nerdtree on start
function! NerdOnRegDir()
  let l:file_count = str2nr(system('ls | wc -l'))
  if l:file_count < 100
    NERDTreeToggle
  endif
endfunction
autocmd VimEnter * call NerdOnRegDir() "Open nerdtree on start
autocmd vimenter * wincmd p " Cursor by default not in NerdTree
let g:NERDTreeWinSize=32 " change nerdtree default size
Plug 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" ------------------------------
" Split Management -------------
Plug 'regedarek/ZoomWin'
nnoremap <leader>zz :ZoomWin<CR>
Plug 'wesQ3/vim-windowswap'
" ------------------------------
" Stylization ------------------
" General enhanced syntax highlighting
Plug 'sheerun/vim-polyglot'
autocmd VimEnter,BufNewFile,BufRead *.dart set syntax=dart
autocmd VimEnter,BufNewFile,BufRead *.ts set syntax=typescript
autocmd VimEnter,BufNewFile,BufRead *.tmux.conf set syntax=tmux
autocmd VimEnter,BufNewFile,BufRead *.service set syntax=gcl
autocmd VimEnter,BufNewFile,BufRead *.cfg set syntax=yaml
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'  " Airline line at the bottom of the screen
set laststatus=2
let g:airline_powerline_fonts = 1
let g:Powerline_symbols='unicode'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
" ------------------------------
" Gutter -----------------------
Plug 'mhinz/vim-signify' " VCS gutter (works with git and g4)
" ------------------------------
" Controls ----------------------
Plug 'ervandew/supertab'

" set completeopt=longest,menuone

let g:SuperTabDefaultCompletionType = "<c-n>"
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
command! VS vs | FZF
command! S  split | FZF
Plug 'junegunn/vim-easy-align'
xmap ga <Plug>(EasyAlign)
" ------------------------------
Plug 'christoomey/vim-tmux-navigator'
" autodetect pasting
Plug 'conradirwin/vim-bracketed-paste'
call plug#end()            " required
filetype plugin indent on    " required
" General ----------------------
let mapleader = "\\" " set leader key to backslash
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
" match Todo /\s\+$/ " highlight trailing spaces
set colorcolumn=80
set backspace=2 " makes backspace remove previous character instead of where the cursor is
set mouse=a " allow point and click UI
set splitbelow " Make new horizontal splits below
set splitright " Make new vertical splits on right
" Mouse fix for tmux
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif
" ------------------------------
" Themes -----------------------
colorscheme Monokai
" ------------------------------
" Search -----------------------
set incsearch  " search as characters are entered
set hlsearch   " highlight matches
" ------------------------------
" Custom Highlighting ----------
so ~/.vimrc.java_highlights
" let java_highlight_all=1
" let java_highlight_functions="style"
" let java_highlight_debug=1
" let java_highlight_java_lang_ids=1
" let java_highlight_functions="style"
" let java_allow_cpp_keywords=1
" autocmd BufEnter,VimEnter *.java silent! call HighlightJavaExtras()
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" ------------------------------
" Tabs -------------------------
retab
set expandtab     " Expand tabs to spaces
set tabstop=2     " Make tabs 2 spaces
set softtabstop=2 " Make deleting a tab delete 2 spaces
set shiftwidth=2  " Make indentaion 2 spaces
au BufRead,BufNewFile *.cc,*.h setl sw=2 sts=2 ts=2 et
au BufRead,BufNewFile *.java setl sw=2 sts=2 ts=2 et
au BufRead,BufNewFile *.py setl sw=4 sts=4 ts=4 et
" ------------------------------
" Auto-Commands ---------------------
au FocusGained,CursorHold,CursorHoldI,BufEnter * checktime
" jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Workaround for suggestion menu issues
" au BufWritePost,InsertLeave,CompleteDone * redraw!
" Don't conceal characters. Applicable for quote hiding in json files
autocmd bufenter * set conceallevel=0
" -----------------------------
"Buffer Navigation ------------
nmap <C-n> :bnext<CR>
nmap <C-b> :bprevious<CR>
" -----------------------------
" Close buffer without closing split
command! BD sb # | bd #
nmap <leader>ss :setlocal spell!<cr>
nmap <leader>pp :setlocal paste!<cr>
command FixImports !/google/src/head/depot/google3/tools/java/fix_imports.py %
command! -nargs=1 Import execute "r!bash -c \"cs -h '^import\ .*\\.<args>;$' 2> /dev/null | head -1 | sed -s 's/^.*: //'\""
nmap <leader>i :Import <cword><cr>
nmap <leader>qq :BD<cr>
autocmd VimEnter * noremap <leader>cs :!cs_url %:p";l="<c-r>=line('.')<CR><CR>
function G4oOpen()
  let file = system('g4o_file')
  echo file
  " execute 'edit' . file
endfunction
noremap <C-p> :call fzf#run({'source': "p4 o \| awk -F'#' '{print $1}' \| sed 's;//depot/;;' \| sed \"s;^;$(p4 --format \'%clientRoot%\' info)/;\"", 'sink': 'e'})<CR>
nmap <leader>co :w <bar> %bd <bar> e# <bar> bd# <CR>
autocmd VimEnter * noremap <leader>CC :!cider_url %:p":"<c-r>=line('.')<CR><CR>
command! F NERDTreeFind
command! Reveal NERDTreeFind
command! Critique !critique_url
function! FF()
  for fpath in split(globpath(expand('%:p:h'), '*'), '/')
    if fpath =~ ".java"
      echo split(fpath, '\.')[0]
    endif
  endfor
endfunction
autocmd InsertLeave,CompleteDone * redraw!
" set timeoutlen=0
set ttimeoutlen=0

autocmd CompleteDone * redraw!
function! CO()
  %bd|e#|bd#
endfunction
command! CO :call CO()
