"===============================================================================
"         はじめに
"===============================================================================

set nocompatible "vi互換の無効化

"===============================================================================
"         neobundleの設定
"===============================================================================
"
" neobundle本体の設定
filetype off
if has('vim_starting')
  " neobundleがインストールされていなかった場合，インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

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
"         neocomplete/neocomplcache
"===============================================================================

NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'

if neobundle#is_installed('neocomplete')
  " neocompleteの設定
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#skip_auto_completion_time = ''

elseif neobundle#is_installed('neocomplcache')
  " neocomplcacheの設定
  
endif

"===============================================================================
"         VimProc
"===============================================================================

NeoBundle 'Shougo/vimproc', {
\ 'build': {
\   'windows': 'make -f make_mingw32.mak',
\   'cygwin': 'make -f make_cygwin.mak',
\   'mac': 'make -f make_mac.mak',
\   'unix': 'make -f make_unix.mak',
\ },
\}

"===============================================================================
"         RSence
"===============================================================================

NeoBundleLazy 'marcus/rsense', {
\ 'autoload': {
\   'filetypes': 'ruby',
\ },
\}

if neobundle#is_installed('neocomplete')
  NeoBundle 'supermomonga/neocomplete-rsense.vim'
elseif neobundle#is_installed('neocomplcache')
  NeoBundle 'Shougo/neocomplcache-rsense.vim'
endif

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

let g:rsenseUseOmniFunc = 1

"===============================================================================
"         neosnippet
"===============================================================================

NeoBundle 'Shougo/neosnippet.vim'

"===============================================================================
"         molokai
"===============================================================================

NeoBundle 'tomasr/molokai'

"===============================================================================
"         typescript-vim
"===============================================================================

NeoBundleLazy 'leafgarland/typescript-vim', {
\ 'autoload': {
\   'filetypes': ['typescript']
\ }
\}
NeoBundleLazy 'jason0x43/vim-js-indent', {
\ 'autoload': {
\   'filetypes': ['javascript', 'typescript', 'html'],
\ }
\}
let g:js_indent_typescript = 1

"===============================================================================
"         typescript-vim
"===============================================================================

NeoBundle 'rust-lang/rust.vim'

"===============================================================================
"         NeoBundleInstall
"===============================================================================
if(!empty(neobundle#get_not_installed_bundle_names()))
  echomsg 'Not installed bundles: '
        \ string(neobundle#get_not_installed_bundle_names())
  if confirm('Install bundles now?', "yes\nNo", 2) == 1
    NeoBundleInstall
    source ~/.vimrc
  endif
end

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
