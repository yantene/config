"インデント関連の設定
set autoindent
set tabstop=2  "Tabの幅
set expandtab  "Tabキーでスペース挿入
set softtabstop=2  "Tabキーによるカーソル移動幅
set shiftwidth=2  "インデント幅
set list  "Tabや改行の可視化

"ヤンクをクリップボードに
set clipboard=unnamed,autoselect

"その他の設定
set number
set showmatch

"SyntaxHighlighting
syntax on
colorscheme ron

"NeoBundle
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neocomplcache-clang_complete.git'
NeoBundle 'Rip-Rip/clang_complete.git'
filetype plugin on
filetype indent on

"NeoComplecache
let g:neocomplcache_enable_at_startup=1

"ClangComplete
let g:neocomplcache_force_overwrite_completefunc=1
let g:clang_complete_auto=1
let g:clang_exec="clang"
let g:clang_use_library=1
let g:clang_library_path="/usr/lib"

"バイナリエディタ
augroup BinaryXXD
  autocmd!
  autocmd BufReadPre *.bin let &binary = 1
  autocmd BufReadPost * call BinReadPost()
  autocmd BufWritePre * call BinWritePre()
  autocmd BufWritePost * call BinWritePost()
  function! BinReadPost()
    if &binary
      silent %!xxd -g 1
      set ft=xxd
    endif
  endfunction
  function! BinWritePre()
    if &binary
      let s:saved_pos = getpos( '.' )
      silent %!xxd -r
    endif
  endfunction
  function! BinWritePost()
    if &binary
      silent %!xxd -g 1
      call setpos( '.', s:saved_pos )
      set nomod
    endif
  endfunction
augroup END
