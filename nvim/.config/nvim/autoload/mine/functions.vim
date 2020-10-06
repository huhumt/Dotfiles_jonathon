function! mine#functions#text() abort
	" set spellchecking
	set spell

	" Add undo points when this punctuation is added
	inoremap <buffer> ! !<C-g>u
	inoremap <buffer> , ,<C-g>u
	inoremap <buffer> . .<C-g>u
	inoremap <buffer> : :<C-g>u
	inoremap <buffer> ; ;<C-g>u
	inoremap <buffer> ? ?<C-g>u
endfunction

function! mine#functions#colorcols() abort
	if &textwidth > 0
		setlocal colorcolumn=+0
	else
		setlocal colorcolumn=80,100
	endif
endfunction
