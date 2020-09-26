let mapleader = "\<Space>"
let maplocalleader = "\\"

if has('packages')
	packadd! gruvbox
	packadd! fzf.vim
endif

" Enables filetype detection as well as filetype specific indent rules and
" plugins
filetype indent plugin on " 
" Enables filetype specific syntaxs
syntax on
