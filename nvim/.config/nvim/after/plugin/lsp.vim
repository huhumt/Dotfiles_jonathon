" Check that we are running inside nvim
if !has('nvim')
  finish
endif
lua <<EOF
	if ( vim.lsp == nil ) then
		vim.api.nvim_command("finish")
	end
	-- Bash Language Server
	require'lspconfig'.bashls.setup{}
	-- Clang Language Server
	require'lspconfig'.ccls.setup{}
	-- Go Language Server
	require'lspconfig'.gopls.setup{}
	-- Python Language Server
	--require'lspconfig'.pyls.setup{}
	-- Vim Language Server
	require'lspconfig'.vimls.setup{}
	-- VUE Language Server
	require'lspconfig'.vuels.setup{}
EOF
function! s:ConfigureBuffer()
	nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> <silent> <Leader>ld <cmd>lua vim.diagnostic.open_float()<CR>
	nnoremap <buffer> <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <buffer> <silent> <leader>k K
	nnoremap <buffer> <silent> <c-]> <cmd>lua vim.lsp.buf.declaration()<CR>
endfunction
if has('autocmd')
	augroup JHLanguageClientAutocmds
		autocmd!
		autocmd FileType sh,c,go,python,vim,vue  call s:ConfigureBuffer()
	augroup END
endif
