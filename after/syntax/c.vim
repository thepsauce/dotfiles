"syn match Normal '!=' conceal cchar=≠
syn match cExtra '->' conceal cchar=→
"syn match Normal '<=' conceal cchar=≤
"syn match Normal '>=' conceal cchar=≥

syn match cExtra '\v[;,(){}[\].]'
hi cExtra ctermfg=208

syn match cMath '\v[!~+\*%=|&^><:?]'
syn match cMath '\-\([>]\)\@!'
syn match cMath '/\([*/]\)\@!'
hi cMath ctermfg=229

hi! link Conceal cExtra

" syn region par1 matchgroup=par1 start=/(/ end=/)/ contains=ALLBUT
" syn region par2 matchgroup=par2 start=/(/ end=/)/ contains=ALLBUT contained
" syn region par3 matchgroup=par3 start=/(/ end=/)/ contains=ALLBUT contained
" hi par1 ctermfg=red
" hi par2 ctermfg=blue
" hi par3 ctermfg=darkgreen

