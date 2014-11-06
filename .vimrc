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
"         neosnippet
"===============================================================================

NeoBundle 'Shougo/neosnippet.vim'

"===============================================================================
"         molokai
"===============================================================================

NeoBundle 'tomasr/molokai'

"===============================================================================
"         vimwiki
"===============================================================================

:let g:vimwiki_list = [{'path': '~/others/wiki/', 'path_html': '~/others/wiki/html/'}]

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
