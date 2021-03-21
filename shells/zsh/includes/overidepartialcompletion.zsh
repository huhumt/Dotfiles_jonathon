# This file will try to provide completion before the default completion system
# This allows me to overide parts of command completion. Normally, this is so I can use fzf.

get_msfvenom_payloads(){
	local cacheFile="$HOME/.msf4/store/modules_metadata.json"
	sed -n '/"type": "payload"/,/"ref_name"/p' "$cacheFile" | \
		grep -E '(ref_name|description)' | \
		cut -d '"' -f 4 | \
		sed -n 'h;n;p;g;p' | \
		sed 'N;s/\n/:/; s/\\n.*$//'
}
overidecomplete(){
	local tokens cmd toadd ret=1 lastWord
	# http://zsh.sourceforge.net/FAQ/zshfaq03.html
	# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags

	# Use zsh's shell parsing to split lbuffer into items
	# This takes into account quoting and escaping
	tokens=(${(z)LBUFFER})

	# If there isn't anythng typed, fall back to old tab binding
	if [ ${#tokens} -lt 1 ]; then
		zle ${overide_default_completion:-expand-or-complete}
		return
	fi

	# Assume the first element
	# TODO: make this work for multiple commands chained with | or > or && etc.
	# TODO: make this work when command prepended with variables eg a=2 foo bar
	# 			foo is the command name
	cmd="${tokens[1]}"
	lastWord="${tokens[-1]}"

	# If using sudo, check the second word
	[ "$cmd" = "sudo" ] && cmd="${tokens[2]}"

	# Check we have pushed space
	# This means that we are not trying to complete a partial word - leave that to zsh's completion system
	if [ "${LBUFFER[-1]}" = " " ]; then
		case "$cmd" in
			# Pacman and yay have almost the same syntac so for simplicities sake, treat them the same
			pacman|yay)
				case "$lastWord" in
					# If I want to install something, give a list of things to install
					-S) toadd="$($cmd -Slq | fzf -m --preview "$cmd -Si {1}" | tr '\n' ' ')"; ret=0 ;;
					# If I want to uninstall something, give a list of things to uninstall
					-R*) toadd="$($cmd -Qeq | fzf -m --preview "$cmd -Qi {1}" | tr '\n' ' ')"; ret=0 ;;
					-Ql) toadd="$($cmd -Qq | fzf -m --preview "$cmd -Qi {1}" | tr '\n' ' ')"; ret=0 ;;
				esac ;;
			msfvenom)
				case "$lastWord" in
					-p|--payload) toadd="$(get_msfvenom_payloads | fzf -m -d \: --with-nth=1 --preview='echo {2}' --preview-window=up:1 | cut -d ':' -f 1| tr '\n' ' ')"; ret=0 ;;
				esac ;;
			ytaudio)
				toadd="\"$(cat "$HOME/Music/youtube-playlists" | fzf -d '	' --with-nth=2 --preview='echo {1}' --preview-window=up:1 | cut -d'	' -f1)\""; ret=0 ;;

		esac
	fi


	if [ "$ret" -eq "0" ]; then
		if [ -n "$toadd" ]; then
			tokens+=("$toadd")
			LBUFFER="${tokens[@]}"
		fi
		zle reset-prompt
		return 0
	else
		zle ${overide_default_completion:-expand-or-complete}
		# Redrawing here means I can use fzf in my completion functions
		# This is not ideal, I would preferably run this after fzf in the completion functions but can't because they are not widgets.
		zle reset-prompt
		return
	fi
}

# Record what ctrl+i is currently set to
# That way we can call it if jhcompletion doesn't result in anything
[ -z "$overide_default_completion" ] && {
	binding=$(bindkey '^I')
	[[ $binding =~ 'undefined-key' ]] || overide_default_completion=$binding[(s: :w)2]
	unset binding
}
zle     -N   overidecomplete
bindkey '^I' overidecomplete



