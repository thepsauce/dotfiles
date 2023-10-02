" Vim syntax file
" Language: ParsEase
if exists("b:current_syntax")
	finish
endif

set conceallevel=2

syn region ParsEaseGroup matchgroup=SpecialChar start="\[" skip="\\\]" end="\]\|\n" contains=ParsEaseEscapeContained,ParsEaseEscapeContained2,ParsEaseGroupContent
syn match ParsEaseEscapeContained "\\[abfnrtv]" contained
syn match ParsEaseEscapeContained2 "\\[^abfnrtv]" contained contains=ParsEaseEscapeContained2Char
syn match ParsEaseEscapeContained2Char "\v((\\\\)*\\@<!.)" contained conceal
syn match ParsEaseGroupContent "[\^\-]" contained

syn match ParsEaseVariableAcc "\v\\[a-zA-Z_0-9]+"
syn match ParsEaseVariable "\v[a-zA-Z0-9_]+"
syn match ParsEaseVariableDecl "\v[a-zA-Z0-9_]+\s*:"

syn match ParsEaseFunction "\v[a-zA-Z0-9_]+\s*\(.*\)" contains=ParsEaseParams
syn region ParsEaseParams start="(" end=")" contained contains=ParsEaseArg,ParsEaseGroup,ParsEaseOperator
syn match ParsEaseArg "\v[a-zA-Z0-9_]+\s*\=" contained

syn region ParsEaseString start="\"" skip="\\\"" end="\"\|\n" contains=ParsEaseEscapeContained

syn match ParsEaseOperator "[<>+*^?.|]"

syn match ParsEaseRef "[0-9]:"
syn match ParsEaseRef "[0-9]\.$"
syn match ParsEaseRef "\.\.$"
syn match ParsEaseRef "\!\!$"
syn match ParsEaseRef "\^\.$"

syn region ParsEaseComment start="^#" end="$"

hi link ParsEaseGroup String
hi link ParsEaseGroupContent SpecialChar
hi link ParsEaseEscapeContained SpecialChar 
hi link ParsEaseEscapeContained2 String
hi link ParsEaseEscapeContained2Char Comment

hi link ParsEaseVariableAcc GruvboxFg1
hi link ParsEaseVariable Identifier
hi link ParsEaseVariableDecl Identifier 

hi link ParsEaseFunction Function 
hi link ParsEaseParams SpecialChar
hi link ParsEaseArg Identifier

hi link ParsEaseString String
hi ParsEaseOperator ctermfg=117
hi link ParsEaseRef Typedef
hi link ParsEaseComment Comment

" Custom indentation
function ParsEaseIndent()
	let line_num = line(".")
	let prev_indent = indent(line_num - 1)
	return prev_indent
endfunction
set indentexpr=ParsEaseIndent()
" Custom bracket pairs
set matchpairs=(:)
set expandtab

let b:current_syntax = "ParsEase"
