filetype off
filetype plugin indent off
"*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

"-------------------------------------------------------------------------------
"         .vimrc 五つの誓い
"
" 一、 .vimrc は極力シンプルに保つべし
" 一、 や、よく考えたら言いたいのこれだけだわ
" 一、
" 一、
" 一、
"-------------------------------------------------------------------------------

"===============================================================================
"         NeoBundle
"===============================================================================

" NeoBundle がインストールされていなかった場合，インストール
if has('vim_starting')
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" インストールするプラグインを指定
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'stephpy/vim-yaml'
NeoBundle 'rhysd/vim-crystal'
call neobundle#end()

" インストールされていないプラグインについて，インストール
if(!empty(neobundle#get_not_installed_bundle_names()))
  echomsg 'Not installed bundles: '
        \ string(neobundle#get_not_installed_bundle_names())
  if confirm('Install bundles now?', "yes\nNo", 2) == 1
    NeoBundleInstall
    source ~/.vimrc
  endif
end

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
set clipboard=unnamedplus,autoselect "ヤンクをクリップボードに

" Syntax Highlightに関する設定
syntax on
colorscheme molokai
set t_Co=256

" エディタに関する設定
set nocompatible "vi互換の無効化
set number "行番号
set list "特殊文字の可視化
set cursorline
set showmatch
set ambiwidth=double "記号フォント幅の修正

" ランタイムの有効化
runtime macros/matchit.vim " % で対応する括弧に飛ぶ

" キーバインドに関する設定
imap <C-c> <C-x><C-o>
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
nnoremap <c-j> <C-f>
nnoremap <c-k> <C-b>

"===============================================================================
"         各種設定
"===============================================================================

"-------------------------------------------------------------------------------
"         neocomplete
"-------------------------------------------------------------------------------

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

"-------------------------------------------------------------------------------
"         Ruby 関係
"-------------------------------------------------------------------------------

" Rubocop
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
filetype plugin indent on
