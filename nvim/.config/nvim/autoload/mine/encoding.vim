" base64 encodes text
" It relies on the executable base64 which should be installed on most unix-y
" systems.
function! mine#encoding#base64Encode(text) abort
	return substitute(system('base64 --wrap=0', a:text), '\n$', '', 'g')
endfunction

" base64 decodes text
" It relies on the executable base64 which should be installed on most unix-y
" systems.
function! mine#encoding#base64Decode(text) abort
	return substitute(system('base64 --decode --ignore-garbage --wrap=0', a:text), '\n$', '', 'g')
endfunction

" hex encodes text
" It relies on the executable xxd
function! mine#encoding#hexEncode(text) abort
	return substitute(system('xxd -p', a:text), '\n$', '', 'g')
endfunction

" base64 decodes text
" It relies on the executable base64 which should be installed on most unix-y
" systems.
function! mine#encoding#hexDecode(text) abort
	return substitute(system('xxd -r -p', a:text), '\n$', '', 'g')
endfunction

" Url encodes characters that are normally encoded in urls
" Taken from https://github.com/tpope/vim-unimpaired/blob/master/plugin/unimpaired.vim
function! mine#encoding#urlEncode(text) abort
	" iconv trick to convert utf-8 bytes to 8bits indiviual char.
	return substitute(iconv(a:text, 'latin1', 'utf-8'),'[^A-Za-z0-9_.~-]','\="%".printf("%02X",char2nr(submatch(0)))','g')
endfunction

" Url decodes text
" Taken from https://github.com/tpope/vim-unimpaired/blob/master/plugin/unimpaired.vim
function! mine#encoding#urlDecode(text) abort
	let text = substitute(substitute(substitute(a:text,'%0[Aa]\n$','%0A',''),'%0[Aa]','\n','g'),'+',' ','g')
	return iconv(substitute(text,'%\(\x\x\)','\=nr2char("0x".submatch(1))','g'), 'utf-8', 'latin1')
endfunction

" Url encodes all characters
function! mine#encoding#urlEncodeAll(text) abort
	" iconv trick to convert utf-8 bytes to 8bits indiviual char.
	return substitute(iconv(a:text, 'latin1', 'utf-8'),'.','\="%".printf("%02X",char2nr(submatch(0)))','g')
endfunction

function! mine#encoding#wrapper(fn) abort
	" keep track of what paste was set to
	let l:paste = &paste
	" make sure it is enabled
	set paste

	" make sure the selection is selected
	normal! gv

	" transform text
	" adapted from: https://github.com/christianrondeau/vim-base64/blob/master/autoload/base64.vim#L36
	execute "normal! c\<c-r>=mine#encoding#" . a:fn . "(@\")\<cr>\<esc>"

	" reset paste to whatever it was before
	let &paste = l:paste
endfunction
