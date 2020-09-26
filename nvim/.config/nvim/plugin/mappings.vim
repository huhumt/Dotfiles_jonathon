" Swaps semi colon to colon in normal mode
nnoremap ; :
nnoremap : ;

" Swaps semi colon to colon in visual mode
vnoremap ; :
vnoremap : ;

" Make jj in insert mode go to normal mode
inoremap jj <Esc>

" Make ctrl+hjkl change focus between windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
