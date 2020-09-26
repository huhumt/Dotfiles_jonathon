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
