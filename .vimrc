"===============================================================================
"         はじめに
"===============================================================================

set nocompatible "vi互換の無効化

"===============================================================================
"         neobundleの設定
"===============================================================================

" neobundle本体の設定
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif
filetype plugin on
filetype indent on

"===============================================================================
"        言語ごとの設定
"===============================================================================

augroup vimrc-lang
  autocmd!
  autocmd FileType c call s:cpp()
  autocmd FileType cpp call s:cpp()
  autocmd FileType java call s:java()
augroup END

" C++の設定
function! s:cpp()
  setlocal path+=/usr/include,/usr/include/c++/4.8.2,/usr/include/boost
  setlocal expandtab
  setlocal tabstop=2
  setlocal softtabstop=2
  setlocal shiftwidth=2
  setlocal matchpairs+=<:>
endfunction

" Javaの設定
function! s:java()
  setlocal expandtab
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal shiftwidth=4
endfunction

"===============================================================================
"         neocomplete.vim
"===============================================================================

NeoBundle 'Shougo/neocomplete.vim'

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#skip_auto_completion_time = ''

"===============================================================================
"         neosnippet
"===============================================================================

NeoBundle 'Shougo/neosnippet.vim'

"===============================================================================
"         vim-smartinput
"===============================================================================

NeoBundle "kana/vim-smartinput"
NeoBundle "cohama/vim-smartinput-endwise"

call smartinput_endwise#define_default_rules()

"===============================================================================
"         vimwiki
"===============================================================================

:let g:vimwiki_list = [{'path': '~/others/wiki/', 'path_html': '~/others/wiki/html/'}]

"===============================================================================
"         vimの設定
"===============================================================================

" インデントに関する設定
set autoindent
set expandtab  "インデントたるもの，スペースたるべし．
set ts=2  "<Tab>文字の幅
set sw=2  "自動インデントの幅
set sts=2 "手動インデントの幅

" ヤンクに関する設定
set clipboard=unnamedplus,autoselect "ヤンクをクリップボードに

" Syntax Highlightに関する設定
syntax on
NeoBundle 'tomasr/molokai'
colorscheme molokai
set t_Co=256

" エディタに関する設定
set number "行番号
set list "特殊文字の可視化
set cursorline
set showmatch
set ambiwidth=double "記号フォント幅の修正

" キーバインドに関する設定
imap <C-c> <C-x><C-o>
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
nnoremap <c-j> <C-f>
nnoremap <c-k> <C-b>

" gvimの設定
set guifont=Ricty\ 11
set guifontwide=Ricty\ 11
