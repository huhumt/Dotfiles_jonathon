" Prefixes all of the fzf commands
let g:fzf_command_prefix = 'Fzf'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

" Mappings for common Fzf commands
nnoremap <leader>f = :FzfFiles<cr>
nnoremap <leader>b = :FzfBuffers<cr>
nnoremap <leader>h = :FzfHelptags<cr>
" The space is important at the end of this mapping
nnoremap <leader>/ = :FzfRg 

function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r ~/Templates/'.a:template
endfunction

command! -bang -nargs=* LoadTemplate call fzf#run({
			\   'source': 'ls -1 ~/Templates',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
