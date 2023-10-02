" This is extending the standard C syntax highlighting
" It includes highlighting of functions and types that end with _t
" It also includes highlighting of words after a 'struct', 'enum' or 'union'
" ncurses standard screen
syn keyword cConstant stdscr

syn keyword cType I8 U8 I16 U16 I32 U32 I64 U64

"syn match cGlobalVariable "\v<[A-Z]+[a-z]*(_[A-Z])?[a-z]+>"
"hi cGlobalVariable ctermfg=229

syn match cOperator '[.!~+\-%|&^:?<>=[\]/*]'

syn match cType "\v<([A-Z][a-z]+)+>"
syn match cType "\v<\h\k*_t>"
syn match cAfter "\v(<(struct|enum|union)>\s+)@<=\h\k*"
syn match cMember "\v(\.|\-\>)@<=\h\k*"
syn match cFunction "\v\h\k*(\()@="

