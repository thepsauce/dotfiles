" general
filetype plugin on
syntax on
filetype indent on
set number relativenumber
set incsearch
set hlsearch
set tabstop=4
set shiftwidth=4
set nowrap
"colo fu
set cole=1

" airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶ '
let g:airline_right_sep = '«'
let g:airline_right_sep = ' ◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇  '
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" gruvbox
set background=dark
let g:gruvbox_bold = '1'
let g:gruvbox_italic = '1'
let g:gruvbox_underline = '1'
let g:gruvbox_undercurl = '1'
colo gruvbox
hi! link Normal GruvboxRed
