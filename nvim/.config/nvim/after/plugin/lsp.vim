" Check that we are running inside nvim
if !has('nvim')
  finish
endif
lua <<EOF
	-- Go Language Server
	require'nvim_lsp'.gopls.setup{}
	-- Vim Language Server
	require'nvim_lsp'.vimls.setup{}
EOF
function! s:ConfigureBuffer()
	nnoremap <buffer> <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> <silent> <Leader>ld <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
	nnoremap <buffer> <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.declaration()<CR>
endfunction
if has('autocmd')
	augroup JHLanguageClientAutocmds
		autocmd!
		autocmd FileType go,vim  call s:ConfigureBuffer()
	augroup END
endif