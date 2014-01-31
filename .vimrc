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
NeoBundle 'osyo-manga/vim-reunions'
NeoBundle 'osyo-manga/vim-marching'
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
"        quickrun & watchdogs
"-------------------------------------------------
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
\   "cmdopt": "-std=gnu++11 -Wall",
\   'tempfile': '%{tempname()}.cpp',
\   'hook/sweep/files': ['%S:p:r'],
\ },
\ 'cpp/g++11': {
\   'command': 'g++',
\   'exec': ['%c %o %s -o %s:p:r', '%s:p:r %a'],
\   "cmdopt": "-std=gnu++11 -Wall",
\   'tempfile': '%{tempname()}.cpp',
\   'hook/sweep/files': '%S:p:r',
\ },
\ "cpp/clang++": {
\   "cmdopt": "-Wall",
\ },
\ "cpp/g++": {
\   "cmdopt": "-Wall",
\ },
\ "watchdogs_checker/_": {
\   "hook/close_unite_quickfix/enable_exit": 1,
\ },
\ "cpp/watchdogs_checker": {
\   "type": "watchdogs_checker/clang++",
\ },
\ "watchdogs_checker/clang++": {
\   "cmdopt": "-Wall",
\ },
\}
let g:watchdogs_check_BufWritePost_enable = 1 "書き込み後のシンタックスチェック
let g:watchdogs_check_CursorHold_enable = 1 "キー入力のない場合のシンタックスチェック
call watchdogs#setup(g:quickrun_config)

"-------------------------------------------------
"        コメントアウト・アンコメント
"-------------------------------------------------
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncommnet)

"-------------------------------------------------
"        C++の補完
"-------------------------------------------------
let g:marching_clang_command = "/usr/bin/clang"
let g:marching_clang_command_option = "-std=gnu++11"
let g:marching_include_paths = [
\ "/usr/include/c++/4.8.2",
\ "/usr/include/boost"
\ ]
let g:marching_enable_neocomplete = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp = 
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
set updatetime=200

"-------------------------------------------------
"        言語ごとの設定
"-------------------------------------------------
" C++の設定
function! s:cpp()
  "setlocal path+=/usr/include,/usr/include/c++/4.8.2,/usr/include/boost
  setlocal expandtab
  setlocal tabstop=2
  setlocal softtabstop=2
  setlocal shiftwidth=2
  setlocal matchpairs+=<:>
endfunction

"Javaの設定
function! s:java()
  setlocal expandtab
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal shiftwidth=4
endfunction

augroup vimrc-lang
  autocmd!
  autocmd FileType cpp call s:cpp()
  autocmd FileType java call s:java()
augroup END

"-------------------------------------------------
"        gvimの設定
"-------------------------------------------------
" フォント設定
set guifont=Ricty\ 11
set guifontwide=Ricty\ 11

"-------------------------------------------------
"        vimの設定
"-------------------------------------------------
" インデント関連の設定
set autoindent
set expandtab  "Tabキーでスペース挿入
set tabstop=2  "Tabの幅
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
