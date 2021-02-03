# this rg command will get a list of files that are not in gitignore or similar
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --color=always --exclude .git --exclude .PlayOnLinux --exclude \"PlayOnLinux\'s virtual drives\""
export FZF_DEFAULT_OPTS="--reverse --ansi --height 40% --bind change:top"
export FZF_CTRL_R_OPTS=""
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --ansi --preview \"fzf-preview {}\""
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --ansi --preview \"fzf-preview {}\""

type -p fzf > /dev/null || return

# Ctrl t and alt c command are set below
sourced="False"

if [ -e /usr/share/fzf/key-bindings.zsh ]; then
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
	sourced="True"
elif [ -e /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
	source /usr/share/doc/fzf/examples/key-bindings.zsh
	source /usr/share/doc/fzf/examples/completion.zsh
	sourced="True"
fi


if [ "$sourced" = "True" ]; then

	fzf_files(){
		# The directory can be passed as arg1
		dir="${1:-$PWD}"
		fd --type f --hidden --follow --color=always --exclude node_modules --exclude .git --exclude .PlayOnLinux --exclude "PlayOnLinux's virtual drives" . "$dir"
	}


	fzf_dirs(){
		dir="${1:-$PWD}"
		fd --type d --hidden --follow --color=always --exclude node_modules --exclude .git --exclude .PlayOnLinux --exclude "PlayOnLinux's virtual drives" . "$dir"
	}

	# This function is used to provide the ctrl+t completion for fzf
	# I find having ctrl+t for files and alt+c for directories quite jaring.
	# This function will try to determine (based on the command) if it should complete files or directories.
	# If it get's it wrong, alt_c will still work by doing the oposite of what it thinks
	fzf_crl_t(){
		local tokens cmd ret=1 lastWord oposite="${1:-false}"
		# http://zsh.sourceforge.net/FAQ/zshfaq03.html
		# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags

		# Use zsh's shell parsing to split lbuffer into items
		# This takes into account quoting and escaping
		tokens=(${(z)LBUFFER})


		# Assume the first element
		# TODO: make this work for multiple commands chained with | or > or && etc.
		# TODO: make this work when command prepended with variables eg a=2 foo bar
		# 			foo is the command name
		cmd="${tokens[1]}"
		lastWord="${tokens[-1]}"

		if [ "${LBUFFER[-1]}" != " " ]; then
			current="$lastWord"
			current="${current/\~/$HOME}"
		else
			current=""
		fi

		# An array of commands that should use dir search instead of file search
		dirCommands=("cd" "find" "fd")

		if [ "$oposite" = "false" ]; then
			(( ${dirCommands[(I)$cmd]} )) && fzf_dirs "$current" || fzf_files "$current"
		else
			(( ${dirCommands[(I)$cmd]} )) && fzf_files "$current" || fzf_dirs "$current"
		fi

	}
	export FZF_CTRL_T_COMMAND="fzf_crl_t"
	export FZF_ALT_C_COMMAND="fzf_crl_t true"

fi
