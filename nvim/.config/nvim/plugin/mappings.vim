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

" Do Shebang line
" <Esc>            - go into normal mode
" :silent          - run command silently
" s/^/…/           - write at the begining of the line
" <bar>            - used to seperate commands
" filetype detect  - attempt to detect filetype again
" :nohlsearch      - un-hilight the search pattern
inoremap <C-y> <Esc>:silent s/^/#!\/usr\/bin\/env / <bar> filetype detect<cr>:nohlsearch<cr>o
" alternative: inoremap <C-y> <Esc>:silent exe ".!which <cWORD>" <bar> s/^/#!/ <bar> filetype detect<cr>YpDi

" Mappings for my encoding functions
vnoremap [b :call mine#encoding#wrapper('base64Encode')<cr>
vnoremap ]b :call mine#encoding#wrapper('base64Decode')<cr>
vnoremap [u :call mine#encoding#wrapper('urlEncode')<cr>
vnoremap ]u :call mine#encoding#wrapper('urlDecode')<cr>
vnoremap [U :call mine#encoding#wrapper('urlEncodeAll')<cr>
vnoremap ]U :call mine#encoding#wrapper('urlDecode')<cr>
vnoremap [h :call mine#encoding#wrapper('hexEncode')<cr>
vnoremap ]h :call mine#encoding#wrapper('hexDecode')<cr>

" Makes the delete key work in insert mode
inoremap <Del> <Right><BS>

" Compiles documents
" The uppercase versions don't push enter an extra time resulting in seeing
" the output of the compile command. Useful for debugging
nnoremap <leader>cc :w! \| !compiler <c-r>%<CR><CR>
nnoremap <leader>cC :w! \| !compiler <c-r>%<CR>
nnoremap <leader>cl :w! \| !compiler <c-r>% letter<CR><CR>
nnoremap <leader>cL :w! \| !compiler <c-r>% letter<CR>

" Opens the compiled documents
" If something like html, it doesn't need to be compiled first
nnoremap <leader>co :!opout <c-r>%<CR><CR>

" Makes vim default to "very magic" searching
nnoremap / /\v
vnoremap / /\v

" Makes vim re-select visual selection when using < or >
vnoremap < <gv
vnoremap > >gv

nnoremap [c :cprevious<cr>zOzz
nnoremap ]c :cnext<cr>zOzz

" Run proselint and put it in the quickfix list
nnoremap <leader>p :call mine#functions#proselint()<CR>

if has('nvim')
	if !empty($SUDO_ASKPASS)
		cnoremap WW w !sudo -A tee % > /dev/null
	else
		cnoremap WW echo "SUDO_ASKPASS variable needs to be set"<cr>
	endif
else
	cnoremap WW w !sudo tee % > /dev/null
endif
