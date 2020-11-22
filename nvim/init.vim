scriptencoding utf-8

"===============================================================================
"         dein.vim
"===============================================================================
augroup cs_hook
  autocmd!
augroup END

function! RelativePath()
  let rpath = substitute(expand('%:p'), getcwd() . '/', '', '')
  if rpath ==# ''
    return ''
  elseif strlen(rpath) > 80
    return rpath[strlen(rpath)-80:]
  else
    return rpath
  endif
endfunction

let s:dein_dir = expand($XDG_CACHE_HOME . '/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
let &runtimepath = s:dein_repo_dir . ',' . &runtimepath

let s:toml = expand($XDG_CONFIG_HOME . '/nvim/dein.toml')
let s:coc_toml = expand($XDG_CONFIG_HOME . '/nvim/dein_coc.toml')
let s:lazy_toml = expand($XDG_CONFIG_HOME . '/nvim/dein_lazy.toml')
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [s:toml, s:coc_toml, s:lazy_toml])
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:coc_toml,  {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

"===============================================================================
"         言語ごとの設定
"===============================================================================
augroup lang_csv
  autocmd BufRead,BufNewFile *.csv setlocal filetype=csv
augroup END

"===============================================================================
"         vim の設定
"===============================================================================
" インデントに関する設定
set autoindent
set expandtab "インデントたるもの，スペースたるべし．
set tabstop=2 "<Tab>文字の幅
set shiftwidth=2 "自動インデントの幅
set softtabstop=2 "手動インデントの幅

" ヤンクに関する設定
set clipboard+=unnamedplus "ヤンクをクリップボードに

" Syntax Highlightに関する設定
syntax enable
set termguicolors "true color を使用

" 表示に関する設定
set pumblend=20 " ポップアップを半透明に

" 検索に関する設定
set ignorecase
set smartcase "大文字を含むときは sensitive に

" エディタに関する設定
let mapleader = "\<Space>"
set background=dark "背景色を黒に
set number "行番号
set list "特殊文字の可視化
set listchars=tab:»-,trail:␣,eol:↲,extends:»,precedes:«,nbsp:%
set cursorline
set showmatch
set cmdheight=2
if exists('&ambiwidth')
  set ambiwidth=double "曖昧な文字幅対策
endif
filetype plugin indent on " filetype plugin

" キーバインドに関する設定
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
