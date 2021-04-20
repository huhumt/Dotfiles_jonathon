let mapleader = "\<Space>"
let maplocalleader = "\\"


if has('packages')
	packadd! AnsiEsc.vim
	packadd! fzf.vim
	packadd! gruvbox
	packadd! lexima.vim
	packadd! ultisnips
	packadd! vim-fugitive
	packadd! vim-json
	packadd! vim-less
	packadd! vim-repeat
	packadd! vim-snippets
	packadd! vim-surround
	packadd! vim-tridactyl
	packadd! vim-vinegar
	if has('nvim')
		packadd! deoplete.nvim
		packadd! deoplete-abook
		packadd! deoplete-lsp
		packadd! deoplete-notmuch
		packadd! firenvim
		lua <<EOF
		if ( vim.lsp ~= nil ) then
			vim.cmd "packadd! nvim-lspconfig"
		end
EOF
	endif
endif

" Enables filetype detection as well as filetype specific indent rules and
" plugins
filetype indent plugin on " 
" Enables filetype specific syntaxs
syntax on

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"


