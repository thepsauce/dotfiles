" General
filetype plugin on
syntax on
filetype indent on
"set foldmethod=syntax
set number relativenumber
set incsearch
set hlsearch
set tabstop=8
set shiftwidth=8
set wrap
set cole=1
set textwidth=80
set autoindent
set copyindent
set preserveindent

" This makes the ~ disappear at empty bottom lines
"let &fillchars ..= ',eob: '

" Airline
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '►'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◄'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇ '
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#whitespace#mixed_indent_algo = 1

" Color theme
"colo fu
" gruvbox
let g:gruvbox_bold = '1'
let g:gruvbox_italic = '1'
let g:gruvbox_underline = '1'
let g:gruvbox_undercurl = '1'
"colo gruvbox
"hi! link Normal GruvboxRed
"colo atom
"colo corn
colo jellybeans

" This is nothing of importance
function CommentHtml()
	if match(getline('.'), '<!-- .* -->') == -1
		:s/<\(.*\)>/<!-- \1 -->/e
	else
		:s/<!-- \(.*\) -->/<\1>/e
	endif
endfunction

nnoremap , :call CommentHtml()<CR>

" I like to use nasm
au BufRead,BufNewFile *.asm set ft=nasm

" dmenu integration in Vim

" Find a file and pass it to cmd
function! DmenuOpen(cmd)
	let fname = system("find . -type f -not -path '*/\.*' -not -name '*.o' -not -name '*.gch' -not -name '*out' | dmenu -i -l 20 -nb '#000016' -nf '#857810' -sf '#ecd200' -sb '#363a59' -p " . a:cmd)
	let fname = substitute(fname, '\n$', '', '')
	if empty(fname)
		return
	endif
	execute a:cmd . " " . fname
endfunction

map <c-f> :call DmenuOpen("e")<cr>

command! -nargs=* Build :call BuildProject(<q-args>)

function! BuildProject(args)
	let cmd="./build.sh"
	execute "!" . l:cmd . " " . a:args
	let error_file = "/tmp/error_file.txt"
	if filereadable(l:error_file)
		execute "cfile " . l:error_file
	endif
endfunction

autocmd VimEnter * if argc() == 0 && !exists("s:stdin") && filereadable("session.vim") | source session.vim | endif

