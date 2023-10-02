" Vim syntax file
" Language: Simple markdown

setlocal conceallevel=2

syn match txtHeader "\v^#+.*$"
syn match txtList "\v^([0-9]+\.)+.*$"
syn match txtRef "\[.*\]" containedin=txtList
syn match txtSepblock "^=\+"
syn match todo "TODO:"
syn match txtComment "^!.*$"
syn region txtItalic matchgroup=Text start="\*" end="\*" concealends 
syn region txtBold matchgroup=Text start="\*\*" end="\*\*" concealends 
syn region txtLocal matchgroup=Text start="&" end="&" concealends 

hi txtHeader ctermfg=blue cterm=bold
hi txtList ctermfg=yellow
hi txtSepblock ctermfg=green
hi txtComment ctermfg=red cterm=italic
hi txtRef ctermfg=red
hi txtItalic cterm=italic
hi txtBold cterm=bold
hi txtLocal ctermfg=yellow cterm=italic

