unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim"

" General
filetype plugin on
syntax on
filetype indent on
"set foldmethod=syntax
set number relativenumber
set incsearch
set hlsearch
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set cole=1
set textwidth=80
set autoindent
set copyindent
set preserveindent
set t_ut=

" For my small laptop screen (this is also good for bigger screens actually
" when you have lots of split windows)
set winwidth=114
set winheight=35

set mouse=a

" Persistent undo ($HOME/.vim/undo must be a present dir)
set undodir=$HOME/.vim/undo
set undofile

set history=10000

" Set up vertical vs block cursor for insert/normal mode
if &term =~ "screen."
    let &t_ti.="\eP\e[1 q\e\\"
    let &t_SI.="\eP\e[5 q\e\\"
    let &t_EI.="\eP\e[1 q\e\\"
    let &t_te.="\eP\e[0 q\e\\"
else
    let &t_ti.="\<Esc>[1 q"
    let &t_SI.="\<Esc>[5 q"
    let &t_EI.="\<Esc>[1 q"
    let &t_te.="\<Esc>[0 q"
endif

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

hi Function     cterm=bold      gui=bold
hi LineNr       ctermbg=234                 guibg=#1c1c1c
hi Normal       ctermfg=189 ctermbg=235 guifg=#d7d7d7   guibg=#262626
hi cAfter       ctermfg=223                 guifg=#d7d7af
hi cOperator    ctermfg=180                 guifg=#afd7d7
hi cDelimiter   ctermfg=186                 guifg=#d7d7d7
hi cMember      ctermfg=79                  guifg=#87afaf
hi Terminal     guibg=#1c1c1c ctermbg=235
hi! link Conceal cOperator
hi! link cFunction Function

let g:terminal_ansi_colors = [
    \'#282828', '#CC241D', '#98971A', '#D79921',
    \'#458588', '#B16286', '#689D6A', '#D65D0E',
    \'#fb4934', '#b8bb26', '#fabd2f', '#83a598',
    \'#d3869b', '#8ec07c', '#fe8019', '#FBF1C7' ]

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

au BufRead,BufNewFile *.prop set ft=prop

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
    let cmd = "build"
    let error_file = "/tmp/error_file.txt"
    execute "!" . l:cmd . " -fdiagnostics-plain-output " . a:args . "2>" .l:error_file
    if filereadable(l:error_file)
        execute "cfile " . l:error_file
    endif
endfunction

au VimEnter * if argc() == 0 && !exists("s:stdin") && filereadable("session.vim") | source session.vim | endif

" Fuzzy vim (kind of replaces dmenu)
import './.vim/pack/other/start/scope.vim/autoload/fuzzy.vim' as fuzzy
nnoremap Z <ScriptCmd>:call s:fuzzy.File()<CR>

hi Normal ctermbg=NONE
hi NonText ctermbg=NONE

if empty($DISPLAY)
    colo industry
    hi! link Conceal Operator
endif

nnoremap ; :
