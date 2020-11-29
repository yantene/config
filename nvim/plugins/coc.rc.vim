let g:coc_node_path = systemlist('which node')[0]

" EXTENSIONS

let g:coc_global_extensions = [
\ 'coc-clangd',
\ 'coc-css',
\ 'coc-docker',
\ 'coc-html',
\ 'coc-json',
\ 'coc-sh',
\ 'coc-solargraph',
\ 'coc-sql',
\ 'coc-tsserver',
\ 'coc-vetur',
\ 'coc-vimlsp'
\]

" ROOT PATTERNS

autocmd FileType ruby let b:coc_root_patterns = ['Gemfile', '.ruby-version']

" SETTINGS

let mapleader = "\<Space>"

" `[g` `]g` キーで診断結果を前後移動
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" `gd` `gy` `gi` `gr` キーで
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" `K` キーでドキュメント表示
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

" `*` キーでシンボルとその参照をハイライト
augroup coc_highlight
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" `<Space>rn` でシンボルのリネーム
nmap <Leader>rn <Plug>(coc-rename)

" 選択範囲をフォーマット
xmap <Leader>f <Plug>(coc-format-selected)
nmap <Leader>f <Plug>(coc-format-selected)

" 現在行に autofix を適用
nmap <Leader>qf  <Plug>(coc-fix-current)

augroup coc_cmdgroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
