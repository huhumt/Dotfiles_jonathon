let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ 'mail.*': {
            \ 'content': 'html',
        \ },
    \ }
\ }

" If we are in firevim, I probably want my normal text settings
" That is, spell on and undo points when punctuation is added
if exists('g:started_by_firenvim')
	call mine#functions#text()
endif
