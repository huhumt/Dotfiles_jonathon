# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

bindkey -M viins "^q" push-input

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search


# By default, Ctrl+d will not close your shell if the command line is filled, this fixes it:
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x' edit-command-line

bindkey -M viins jj vi-cmd-mode

# Make CTRL-Z background things and unbackground them.
# Based off https://github.com/wincent/wincent/commit/30b502d811fbf4ca058db3a6f006aaecab68f6b7
function fg-bg() {
	if [[ $#BUFFER -eq 0 ]]; then
		local backgroundProgram="$(jobs | tail -n 1 | awk '{print $4}')"
		case "$backgroundProgram" in
			"nc"|"ncat"|"netcat"|"resize-netcat-listener"|"rnc")
				# Make sure that /dev/tty is given to the stty command by doing </dev/tty
				terminal-size-clip < /dev/tty
				stty raw -echo < /dev/tty; fg
				;;
			*)
				fg
				;;
		esac
	else
		zle push-input
	fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

rationalise-dot() {
	if [[ $LBUFFER = *.. ]]; then
		LBUFFER+=/..
	else
		LBUFFER+=.
	fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

make_current_word_directory(){
	tokens=(${(z)LBUFFER})
	local folder="${tokens[-1]}" output
	if [ "${folder[1]}" = '"' ] || [ "${folder[1]}" = "'" ]; then
		folder=${folder:1}
	else
		folder="${folder//\\ / }"
	fi
	folder="${~folder%/*}"
	if [ -e "${~folder}" ]; then
		zle -M "$folder already exists"
	else
		output="$(mkdir -p "${~folder}" 2>&1)"
		if [ $? -eq 0 ]; then
			zle -M "$folder created"
		else
			zle -M "$output"
		fi
	fi
}
zle -N make_current_word_directory
# Alt + m
bindkey '\em' make_current_word_directory

# This came about because I often find myself starting off with cd, tabbing and
# realising I would have been better off starting the command with vim
swap_command(){
	# Each group should be seperated by a colon with each item in a group 
	# seperated by a space
	local groups="cd vim ls:ping mtr"
	local tokens=(${(z)LBUFFER})
	local cmd="${tokens[1]}"
	local newindex=0
	# If there is no command, return
	[ "$cmd" = "" ] && return 0

	# Find the first group group with the current command
	local group="$(echo -en "$groups" | tr ':' '\n' | grep "$cmd" | head -n 1)"
	# Turn the chosen group into an array, splitting on a space
	local commands=(${(@s/ /)group})
	# Find out where the current command is in the list
	local currentindex=${commands[(ie)${cmd}]}

	if [ "$currentindex" -gt "${#commands}" ]; then
		# If the element isn't found in an array, zsh's search returns length + 1
		return 0
	elif [ "$currentindex" -eq "${#commands}" ]; then 
		newindex=1
	else
		newindex="$((currentindex + 1))"
	fi

	tokens[1]="${commands[$newindex]}"
	LBUFFER="${tokens[@]}"
	zle reset-prompt
	return 0
}
zle -N swap_command
bindkey '\ec' swap_command


find_current_file(){
	tokens=(${(z)LBUFFER})
	local lastWord="${tokens[-1]}" filepath
	# First assume I'm trying to edit a script. If it's in my path, use it
	filepath="$(which "$lastWord")"
	if [ "$?" -eq 0 ]; then
		tokens[-1]="$filepath"
		LBUFFER="${tokens[@]}"
		return 0
	fi
	# Next try locate with an exact filename match
	filepath="$(locate "*/$lastWord")"
	if [ "$?" -eq 0 ]; then
		tokens[-1]="$filepath"
		LBUFFER="${tokens[@]}"
		return 0
	fi
}
zle -N find_current_file
# ctrl + n
bindkey '^n' find_current_file


