" This is extending the standard C syntax highlighting
" It includes highlighting of functions and types that end with _t
" It also includes highlighting of words after a 'struct', 'enum' or 'union'

" ncurses standard screen
syn keyword cConstant stdscr

syn keyword cType I8 U8 I16 U16 I32 U32 I64 U64

syn keyword cType TOKEN INT FLOAT COMPLEX VALUE VARIABLE FUNCTION GROUP

"syn match cGlobalVariable "\v<[A-Z]+[a-z]*(_[A-Z])?[a-z]+>"
"hi cGlobalVariable ctermfg=229

syn match cAfter "\v(<(struct|enum|union)>\s+)@<=[a-zA-Z_]\w*"
syn match cFunction "\v[a-zA-z_][a-zA-Z0-9_]*\w*(\()@="
syn match cUnderscoreT "\v<[a-zA-Z_][a-zA-Z0-9_]*_t>"

hi cAfter ctermfg=magenta
hi link cFunction Function
hi link cUnderscoreT Type
hi Normal ctermfg=108
