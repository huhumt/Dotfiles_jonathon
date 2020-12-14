" Always show a statusline
set laststatus=2

" Get current filetype
function! CheckFT(filetype)
	if a:filetype == ''
		return '-'
	else
		return tolower(a:filetype)
	endif
endfunction

" set colors for statusline based on mode
function! DetectMode(mode)
	if empty($DISPLAY)
		let left=""
		let right=""
	else
		let left=""
		let right=""
	end

	let statusline=""
	" Mode
	if a:mode == 'n'
		let statusline .= "%#GruvboxBg4#\ " . left
		let statusline .= "%#PmenuThumb#NORMAL"
		let statusline .= "%#GruvboxBg4#" . right . "\ "
	elseif a:mode == 'i'
		let statusline .= "%#GruvboxBlue#\ " . left
		let statusline .= "%#PmenuSel#INSERT"
		let statusline .= "%#GruvboxBlue#" . right . "\ "
	elseif a:mode == 'R'
		let statusline .= "%#GruvboxRed#\ " . left
		let statusline .= "%#DiffDelete#REPLACE"
		let statusline .= "%#GruvboxRed#" . right . "\ "
	elseif a:mode ==# 'v'
		let statusline .= "%#GruvboxAqua#\ " . left
		let statusline .= "%#DiffChange#VISUAL"
		let statusline .= "%#GruvboxAqua#" . right . "\ "
	elseif a:mode ==# 'V'
		let statusline .= "%#GruvboxAqua#\ " . left
		let statusline .= "%#DiffChange#VISUAL"
		let statusline .= "%#GruvboxAqua#" . right . "\ "
	elseif a:mode ==# ''
		let statusline .= "%#GruvboxAqua#\ " . left
		let statusline .= "%#DiffChange#VISUAL"
		let statusline .= "%#GruvboxAqua#" . right . "\ "
	elseif a:mode ==# 'c'
		let statusline .= "%#GruvboxBg2#\ " . left
		let statusline .= "%#Pmenu#COMMAND"
		let statusline .= "%#GruvboxBg2#" . right . "\ "
	elseif a:mode ==# 't'
		let statusline .= "%#ModeTFGCS#\ " . left
		let statusline .= "%#ModeTFGC#\ TERMINAL\ "
		let statusline .= "%#ModeTFGCS#" . right . "\ " . left
		let statusline .= "%#ModeTFGC#%[%n\ ̷%{bufnr('$')}\ "
	elseif a:mode == 's' || a:mode == 'S' || a:mode == '^S'
		let statusline .= "%#GruvboxAqua#\ " . left
		let statusline .= "%#DiffChange#VISUAL"
		let statusline .= "%#GruvboxAqua#" . right . "\ "
	endif
	" Filename
	" grey = normal
	" aqua = modified
	" red = read only and not modified
	if &mod == 1
		let statusline .= "%#GruvboxAqua#\ " . left
		let statusline .= "%#DiffChange#%.20f"
		let statusline .= "%#GruvboxAqua#" . right . "\ "
	else
		if &readonly == 1
			let statusline .= "%#GruvboxRed#\ " . left
			let statusline .= "%#DiffDelete#%.20f"
			let statusline .= "%#GruvboxRed#" . right . "\ "
		else
			let statusline .= "%#GruvboxBg4#\ " . left
			let statusline .= "%#PmenuThumb#%.20f"
			let statusline .= "%#GruvboxBg4#" . right . "\ "
		endif
	endif

	" Seperator
	let statusline .= "%="

	" git branch
	if exists("*FugitiveHead")
		let head = FugitiveHead()
		if head != ''
			let statusline .= "%#GruvboxBg4#\ " . left
			let statusline .= "%#PmenuThumb#" . head
			let statusline .= "%#GruvboxBg4#" . right . "\ "
		endif
	endif

	" Filetype
	let statusline .= "%#GruvboxBlue#\ " . left
	let statusline .= "%#PmenuSel#%{CheckFT(&filetype)}"
	let statusline .= "%#GruvboxBlue#" . right . "\ "

	" Cursor location and file length
	let statusline .= "%#GruvboxYellow#\ " . left
	let statusline .= "%#Search#%c:%l\ %#IncSearch#\ %L"
	let statusline .= "%#GruvboxOrange#" . right . "\ "


	return statusline
endfunction

set statusline=%!DetectMode(mode())
