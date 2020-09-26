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

if has('clipboard')
	" Make Ctrl C and Ctrl V work on system clipboard
	" if in visual or insert mode respectively
	vnoremap <C-c> "+y
	inoremap <C-v> <Esc>"+pa
endif

" Fix previous spelling mistake in insert mode
" Shamelessly taken from https://castel.dev/post/lecture-notes-1/
" <c-g>u - break undo sequence (new change)
" <Esc>  - go into normal mode
" [s     - go to previous spelling mistake
" 1z=    - change to the top spelling suggestion
" `]     - go to the end of the last changed word
" a      - enter insert mode
" <c-g>u - break undo sequence (new change)
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
