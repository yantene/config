let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'fugitive', 'readonly', 'relativepath', 'modified' ],
\             [ 'cocstatus' ]],
\   'right': [ [ 'lineinfo' ],
\              [ 'percent' ],
\              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ]]
\ },
\ 'component_function': {
\    'relativepath': 'RelativePath',
\    'cocstatus': 'coc#status'
\ },
\}
