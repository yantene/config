let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'fugitive', 'readonly', 'relativepath', 'modified' ],
\             [ 'cocstatus' ]],
\   'right': [ [ 'lineinfo' ],
\              [ 'percent' ],
\              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ],
\              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]],
\ },
\ 'component_function': {
\    'relativepath': 'RelativePath',
\    'cocstatus': 'coc#status'
\ },
\}
