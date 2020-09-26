let mapleader = "\<Space>"
let maplocalleader = "\\"

if has('packages')
	packadd! fzf.vim
	packadd! gruvbox
	packadd! vim-json
	packadd! vim-less
	packadd! vim-repeat
	packadd! vim-surround
	packadd! vim-tridactyl
	packadd! vim-vinegar
endif

" Enables filetype detection as well as filetype specific indent rules and
" plugins
filetype indent plugin on " 
" Enables filetype specific syntaxs
syntax on
