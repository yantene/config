"===============================================================================
"         dein.vim
"===============================================================================
augroup MyAutoCmd
  autocmd!
augroup END

let s:dein_dir = expand($XDG_CACHE_HOME . '/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

let s:toml = expand($XDG_CONFIG_HOME . '/nvim/dein.toml')
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [s:toml])
  call dein#load_toml(s:toml)
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

"===============================================================================
"         easymotion
"===============================================================================
nmap f <plug>(easymotion-overwin-f2)

"===============================================================================
"         vim の設定
"===============================================================================
" インデントに関する設定
set autoindent
set expandtab  "インデントたるもの，スペースたるべし．
set ts=2  "<Tab>文字の幅
set sw=2  "自動インデントの幅
set sts=2 "手動インデントの幅

" ヤンクに関する設定
set clipboard+=unnamedplus "ヤンクをクリップボードに

" Syntax Highlightに関する設定
syntax enable
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 "true color を使用

" エディタに関する設定
set number "行番号
set relativenumber "相対行番号
set list "特殊文字の可視化
set listchars=tab:»-,trail:␣,eol:↲,extends:»,precedes:«,nbsp:%
set cursorline
set showmatch
if exists('&ambw')
  set ambw=double "曖昧な文字幅対策
endif

" ランタイムの有効化
runtime macros/matchit.vim " % で対応する括弧に飛ぶ

" キーバインドに関する設定
imap <C-c> <C-x><C-o>
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
nnoremap <C-j> <C-f>
nnoremap <C-k> <C-b>
nnoremap <S-j> <C-e>
nnoremap <S-k> <C-y>
