syn match cDelimiter '[;,(){}]'

syn match cOperator '!=' conceal cchar=≠
syn match cOperator '->' conceal cchar=→
syn match cOperator '<<' conceal cchar=«
syn match cOperator '>>' conceal cchar=»
syn match cOperator '<=' conceal cchar=≤
syn match cOperator '>=' conceal cchar=≥

" syn region par1 matchgroup=par1 start=/(/ end=/)/ contains=ALLBUT
" syn region par2 matchgroup=par2 start=/(/ end=/)/ contains=ALLBUT contained
" syn region par3 matchgroup=par3 start=/(/ end=/)/ contains=ALLBUT contained
" hi par1 ctermfg=red
" hi par2 ctermfg=blue
" hi par3 ctermfg=darkgreen

