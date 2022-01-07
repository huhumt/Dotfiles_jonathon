" Set colourscheme to gruvbox
let g:gruvbox_italic=1
set termguicolors
colorscheme gruvbox

" Set spellcheck language to english
set spelllang=en_gb

" Set default split to be right or bottom
set splitright
set splitbelow

" Tell vim it's a fast terminal
set ttyfast

" set relative ruler with current line as real line number
set relativenumber
set number

" Allows vim to background buffers without saving
set hidden

" Sets vim to smart case
" If search is all lowercase, search insensitively; if you include a capital
" it becomes a case sensitive match
set ignorecase smartcase

" Makes vim try to keep 5 lines visible at the top and bottom
set scrolloff=5

" set tabwidth
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4

" Add invisivle character reperesentation
set list listchars=tab:»\ ,trail:\␣,eol:↩

" Stops vim wrapping in the middle of a word
set linebreak

" Sets tool for opening non-text files with gx
" If in netrw, this is run with just x
let g:netrw_browsex_viewer = "opout"

" Automatically insert comment leader after hitting enter
set formatoptions+=r
" Automatically insert comment leader after hitting o or O
set formatoptions+=o

" Show the results of the substitute command as you type
set inccommand=nosplit

" Sets the default fold method to indent
set foldmethod=indent

if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --color=never\ --glob=\"!shell-logs/*\"
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

augroup colorcols
	autocmd!
	autocmd FileType,VimEnter,BufEnter * call mine#functions#colorcols()
augroup end

" share data between nvim instances (registers etc)
augroup SHADA
	autocmd!
	autocmd CursorHold,TextYankPost,FocusGained,FocusLost *
		\ if exists(':rshada') | rshada | wshada | endif
augroup END
