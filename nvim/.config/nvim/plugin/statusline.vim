" Always show a statusline
set laststatus=2

" Make it empty so we can add to it
set statusline=
" Space character
set statusline+=\ 
" Short file name
set statusline+=%f
" Space character
set statusline+=\ 
" Read only flag
set statusline+=%r
" Space character
set statusline+=\ 
" Modified flag
set statusline+=%m
" Seperator
set statusline+=%=
" Git branch
set statusline+=%{FugitiveStatusline()}
" Space character
set statusline+=\ 
" column number
set statusline+=%c
set statusline+=:
" Line number
set statusline+=%l
" Literal `/`
set statusline+=/
" Total number of lines
set statusline+=%L
" Space character
set statusline+=\ 
" File type
set statusline+=%y
