"-------------------------------------------------
"        neobundle
"-------------------------------------------------
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'tyru/caw.vim'
NeoBundle 'jceb/vim-hier'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'osyo-manga/unite-quickrun_config.git'
NeoBundle 'tomasr/molokai'
filetype plugin on
filetype indent on

"-------------------------------------------------
"        neocomplete
"-------------------------------------------------
let g:neocomplete#enable_at_startup = 1 "補完を有効に
let g:neocomplete#enable_ignore_case = 1 "
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyboard_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

"-------------------------------------------------
"        quickrun
"-------------------------------------------------
let g:watchdogs_check_BufWritePost_enable = 1
let g:quickrun_config = {
\ "_": {
\   "hook/close_unite_quickfix/enable_hook_loaded": 1,
\   "hook/unite_quickfix/enable_failure": 1,
\   "hook/close_quickfix/enable_exit": 1,
\   "hook/close_buffer/enable_failure": 1,
\   "hook/close_buffer/enable_empty_data": 1,
\   "outputter": "multi:buffer:quickfix",
\   "hook/nuko/enable": 1,
\   "hook/nuko/wait": 5,
\   "outputter/buffer/split": ":botright 10sp",
\   "runner": "vimproc",
\   "runner/vimproc/updatetime": 40,
\ },
\ "cpp": {
\   'type':
\     executable('clang++')   ? 'cpp/clang++11':
\     executable('g++')       ? 'cpp/g++11':
\     '',
\ },
\ 'cpp/clang++11': {
\   'command': 'clang++',
\   'exec': ['%c %o %s -o %s:p:r', '%s:p:r %a'],
\   "cmdopt": "-std=c++11 -Wall",
\   'tempfile': '%{tempname()}.cpp',
\   'hook/sweep/files': ['%S:p:r'],
\ },
\ 'cpp/g++11': {
\   'command': 'g++',
\   'exec': ['%c %o %s -o %s:p:r', '%s:p:r %a'],
\   "cmdopt": "-std=c++11 -Wall",
\   'tempfile': '%{tempname()}.cpp',
\   'hook/sweep/files': '%S:p:r',
\ },
\ "cpp/clang++": {
\   "cmdopt": "-Wall",
\ },
\ "cpp/g++": {
\   "cmdopt": "-Wall",
\ },
\ "cpp/watchdogs_checker": {
\   "type": "watchdogs_checker/clang++",
\ },
\ "watchdogs_checker/clang++": {
\   "cmdopt": "-Wall",
\ },
\}

"-------------------------------------------------
"        コメントアウト・アンコメント
"-------------------------------------------------
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncommnet)

"-------------------------------------------------
"        C++に関する設定
"-------------------------------------------------
function! s:cpp()
  setlocal path+=/usr/include/c++/4.8.2,/usr/include/boost
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal expandtab
  setlocal matchpairs+=<:>
endfunction

"-------------------------------------------------
"        vimの設定
"-------------------------------------------------
" インデント関連の設定
set autoindent
set tabstop=2  "Tabの幅
set expandtab  "Tabキーでスペース挿入
set softtabstop=2  "Tabキーによるカーソル移動幅
set shiftwidth=2  "インデント幅
set list  "Tabや改行の可視化

" ヤンクをクリップボードに
set clipboard=unnamedplus,autoselect

" Syntax Highlighting
syntax on
colorscheme molokai

" その他の設定
set number
set cursorline
set t_Co=256
set showmatch
