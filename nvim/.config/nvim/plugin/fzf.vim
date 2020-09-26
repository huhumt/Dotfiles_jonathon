" Prefixes all of the fzf commands
let g:fzf_command_prefix = 'Fzf'
" Mappings for common Fzf commands
nnoremap <leader>f = :FzfFiles<cr>
nnoremap <leader>b = :FzfBuffers<cr>
nnoremap <leader>h = :FzfHelptags<cr>
" The space is important at the end of this mapping
nnoremap <leader>/ = :FzfRg 
