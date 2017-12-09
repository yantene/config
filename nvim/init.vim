"===============================================================================
"         dein.vim
"===============================================================================
augroup cs_hook
  autocmd!
augroup END

augroup ctags_hook
  autocmd!
augroup END

let s:dein_dir = expand($XDG_CACHE_HOME . '/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

let s:toml = expand($XDG_CONFIG_HOME . '/nvim/dein.toml')
let s:lazy_toml = expand($XDG_CONFIG_HOME . '/nvim/dein_lazy.toml')
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [s:toml, s:lazy_toml])
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

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
set background=dark "背景色を黒に
set number "行番号
set list "特殊文字の可視化
set listchars=tab:»-,trail:␣,eol:↲,extends:»,precedes:«,nbsp:%
set cursorline
set showmatch
if exists('&ambw')
  set ambw=double "曖昧な文字幅対策
endif
filetype plugin indent on " filetype plugin

" キーバインドに関する設定
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
noremap <C-j> <C-f>
noremap <C-k> <C-b>
noremap <S-j> <C-e>
noremap <S-k> <C-y>
