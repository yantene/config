let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'fugitive', 'readonly', 'relativepath', 'modified' ]],
\   'right': [ [ 'lineinfo' ],
\              [ 'percent' ],
\              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ],
\              [ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok']]
\ },
\ 'component_function': {
\    'relativepath': 'RelativePath'
\ },
\}
