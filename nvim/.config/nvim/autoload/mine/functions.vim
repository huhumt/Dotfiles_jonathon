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

function! mine#functions#proselint() abort
	let oldmakeprg = &l:makeprg
	" set new value of makeprg and call the function
	set makeprg=proselint\ %
	make
	copen
	" set makeprg back to old value
	let &l:makeprg = oldmakeprg
endfunction

function! mine#functions#languagetool() abort
	let oldmakeprg = &l:makeprg
	let olderrformat = &l:errorformat
	" set new value of makeprg and call the function
	set makeprg=languagetool\ -l\ en-GB\ %
	let &l:errorformat =
		  \ '%-GPicked up _JAVA_OPTIONS: %.%#,' .
		  \ '%-GExpected text language: %.%#,' .
		  \ '%-PWorking on %f...,' .
		  \ '%-I%.%# [main] DEBUG %.%#,' .
		  \ '%+IUsing %.%# for file %.%#,' .
		  \ '%I%\d%\+.) Line %l\, column %c\, Rule ID: %m,' .
		  \ '%-CMessage%m,' .
		  \ '%-CSuggestion%m,' .
		  \ '%-CMore info%m,' .
		  \ '%-C%\s%#^%\+%\s%#,' .
		  \ '%-C%.%#,' .
		  \ '%-Z%\s%#,' .
		  \ '%-Q,' .
		  \ '%-GTime: %.%#'
	make
	copen
	" set makeprg back to old value
	let &l:makeprg = oldmakeprg
	let &l:makeprg = olderrformat
endfunction
