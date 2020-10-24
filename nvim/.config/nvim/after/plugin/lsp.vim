" Check that we are running inside nvim
if !has('nvim')
  finish
endif
lua <<EOF
	-- Bash Language Server
	require'nvim_lsp'.bashls.setup{}
	-- Clang Language Server
	require'nvim_lsp'.clangd.setup{}
	-- Go Language Server
	require'nvim_lsp'.gopls.setup{}
	-- Python Language Server
	require'nvim_lsp'.pyls.setup{}
	-- Vim Language Server
	require'nvim_lsp'.vimls.setup{}
	-- VUE Language Server
	require'nvim_lsp'.vuels.setup{}
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
