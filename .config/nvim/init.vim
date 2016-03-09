"===============================================================================
"         NeoBundle
"===============================================================================

" NeoBundle がインストールされていなかった場合，インストール
if has('vim_starting')
  if !isdirectory(expand("~/.config/nvim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim")
  endif
  set runtimepath+=~/.config/nvim/bundle/neobundle.vim
endif

" インストールするプラグインを指定
call neobundle#begin(expand('~/.config/nvim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'tomasr/molokai'
"NeoBundle 'scrooloose/syntastic'
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
    source ~/.config/nvim/init.vim
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
set clipboard+=unnamedplus "ヤンクをクリップボードに

" Syntax Highlightに関する設定
syntax on
colorscheme molokai
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 "true color を使用

" エディタに関する設定
set number "行番号
set list "特殊文字の可視化
set listchars=tab:»-,trail:␣,eol:↲,extends:»,precedes:«,nbsp:%
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
nnoremap <S-j> <C-e>
nnoremap <S-k> <C-y>
