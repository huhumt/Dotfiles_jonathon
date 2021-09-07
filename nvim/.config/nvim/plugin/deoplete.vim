" If we aren't in nvim, exit
if !has('nvim')
  finish
endif

" Make deoplete start at startup
let g:deoplete#enable_at_startup = 1

" Closes the preview window once a completion is done
autocmd CompleteDone * silent! pclose!
