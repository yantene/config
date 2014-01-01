"neobundle
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif
NeoBundle 'Shougo/neocomplete'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimproc', {
\ 'build': {
\   'windows': 'make -f make_mingw32.mak',
\   'cygwin': 'make -f make_cygwin.mak',
\   'mac': 'make -f make_mac.mak',
\   'unix': 'make -f make_unix.mak',
\ },
\}
NeoBundle 'tomasr/molokai'
filetype plugin on
filetype indent on

"neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyboard_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

"quickrun
let g:quickrun_config = {
\ "_": {
\   "runner": "vimproc",
\   "runner/vimproc/updatetime": 60
\ },
\ "cpp/clang++": {
\   "cmdopt": "-std=c++11"
\ },
\}

"インデント関連の設定
set autoindent
set tabstop=2  "Tabの幅
set expandtab  "Tabキーでスペース挿入
set softtabstop=2  "Tabキーによるカーソル移動幅
set shiftwidth=2  "インデント幅
set list  "Tabや改行の可視化

"ヤンクをクリップボードに
set clipboard=unnamedplus,autoselect

"Syntax Highlighting
syntax on
colorscheme molokai

"その他の設定
set number
set cursorline
set t_Co=256
set showmatch
