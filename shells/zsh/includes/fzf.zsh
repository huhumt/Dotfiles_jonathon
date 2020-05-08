# this rg command will get a list of files that are not in gitignore or similar
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --color=always --exclude .git --exclude .PlayOnLinux --exclude \"PlayOnLinux\'s virtual drives\""
export FZF_DEFAULT_OPTS="--reverse --ansi --height 40%"
export FZF_CTRL_R_OPTS=""
# this is the argument completeion optionm, use the same command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --ansi --preview \"bat --style=numbers --color=always {}\""

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
	# jhComplete(){
	# 	local comp=$(echo $1 | cut -d':' -f1)
	# 	local prompt=$(echo $1 | cut -d':' -f2)
	# 	local currentProject=$(project current --path)
	# 	find "$HOME/.local/share/snippets/" -name \*.func | while read line; do
	# 		source "$line"
	# 	done
	# 	case "${comp}" in
	# 		ip)
	# 			if [ -n "$currentProject" ]; then
	# 				project hosts ip --fzf
	# 			fi
	# 			;;
	# 		myip)
	# 			ip route | grep -oE '(dev|src) [^ ]+' | sed 'N;s/\n/,/;s/src //' | awk -F',' '{print $2 " " $1}' | sort -u | fzf --no-preview | cut -d' ' -f1
	# 			;;
	# 		pf)
	# 			if [ -n "$currentProject" ]; then
	# 				find "$currentProject" -type f | fzf
	# 			fi
	# 			;;
	# 		pd)
	# 			if [ -n "$currentProject" ]; then
	# 				find "$currentProject" -type d | fzf --no-preview
	# 			fi
	# 			;;
	# 		wl|wordlist)
	# 			__fsel_wordlist
	# 			;;
	# 		snip)
	# 			snippets
	# 			;;
	# 		network-interface|int)
	# 			ip -o link show | cut -d' ' -f2- | sed -E 's/[^:]+(UP|DOWN).*/\1/' | tr ':' ' ' | fzf --preview="interface=\$(echo {} | cut -f1 -d' ');ip address show \$interface" | cut -d' ' -f1
	# 			;;
	# 		*)
	# 			if command -v "jhcomplete::$comp" > /dev/null; then
	# 				"jhcomplete::$comp"
	# 			else
	# 				echo ""
	# 			fi
	# 	esac
	# }


	# on_word_replace(){
	# 	setopt localoptions noshwordsplit noksh_arrays noposixbuiltins
	# 	local word="${LBUFFER##* }${RBUFFER%% *}"
	# 	if [ -n "$word" ]; then
	# 		local changeto=$(jhswap "$word" )
	# 		local lastWord="$changeto"
	# 		local LWORDS=$(echo $LBUFFER | tr ' ' '\n' | wc -l)
	# 		local RWORDS=$(echo $RBUFFER | tr ' ' '\n' | wc -l)
	# 		if [ "$LWORDS" -gt "1" ]; then
	# 			LBUFFER="${LBUFFER% *} $lastWord"
	# 		else
	# 			LBUFFER="$lastWord"
	# 		fi
	# 		if [ "$RWORDS" -gt "1" ]; then
	# 			RBUFFER=" ${RBUFFER#* }"
	# 		else
	# 			RBUFFER=""
	# 		fi
	# 		zle reset-prompt
	# 		zle -R
	# 		return 0
	# 	fi

	# }

	# Prompts the user to select a wordlist from the wordlists folder
	wordlistSelect() {
		fd -a --type f --hidden --follow --color=always --exclude .git --exclude \*.md --exclude \*.gif --exclude \*.jpg --exclude \*.png --exclude \*.lua --exclude \*.jar --exclude \*.pl '' /usr/share/wordlists/ | fzf --preview 'bat --color=always {}'
	}

	word_replace(){
		local ret=1
		local word="$1"
		local cmd="$2"
		case "$word" in
			wl) wordlistSelect; return 0 ;;
			myip) ip route | grep -oE '(dev|src) [^ ]+' | sed 'N;s/\n/,/;s/src //;s/dev //' | awk -F',' '{print $2 " " $1}' | sort -u | fzf -1 --no-preview | cut -d' ' -f1; return 0 ;;
		esac
		return "$ret"
	}

	jh_tabcomplete(){
		local tokens cmd swap ret=1 lastWord
		# http://zsh.sourceforge.net/FAQ/zshfaq03.html
		# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags

		# Use zsh's shell parsing to split lbuffer into items
		# This takes into account quoting and escaping
		tokens=(${(z)LBUFFER})

		# If there isn't anythng typed, fall back to old tab binding
		if [ ${#tokens} -lt 1 ]; then
			zle ${jhcomplete_default_completion:-expand-or-complete}
			return
		fi

		# Assume the first element
		# TODO: make this work for multiple commands chained with | or > or && etc.
		# TODO: make this work when command prepended with variables eg a=2 foo bar
		# 			foo is the command name
		cmd="${tokens[1]}"
		lastWord="${tokens[-1]}" 

		# This part checks to see if the whole "word" is replaceable
		if [ "${LBUFFER[-1]}" != " " ]; then
			swap="$(word_replace "$lastWord" "$cmd")"
			ret="$?"
		fi

		# This part checks if the part after an = is completable
		if [ "$ret" -ne "0" ]; then
			local afterEqual="${lastWord##*=}"
			local beforeEqual="${lastWord%=*}"
			# If they are different, there is an equals in the word
			if [ "$afterEqual" != "$lastWord" ]; then
				swap="${beforeEqual}=$(word_replace "$afterEqual" "$cmd")"
				ret="$?"
			fi
		fi

		if [ "$ret" -eq "0" ]; then
			if [ -n "$swap" ]; then
				tokens[-1]="$swap"
				LBUFFER="${tokens[@]}"
			fi
			zle reset-prompt
			return 0
		else
			zle ${jhcomplete_default_completion:-expand-or-complete}
			# Redrawing here means I can use fzf in my completion functions
			# This is not ideal, I would preferably run this after fzf in the completion functions but can't because they are not widgets.
			zle reset-prompt
			return
		fi
	}
	
	# Record what ctrl+i is currently set to
	# That way we can call it if jhcompletion doesn't result in anything
	[ -z "$jhcomplete_default_completion" ] && {
		binding=$(bindkey '^I')
		[[ $binding =~ 'undefined-key' ]] || jhcomplete_default_completion=$binding[(s: :w)2]
		unset binding
	}
	zle     -N   jh_tabcomplete
	bindkey '^I' jh_tabcomplete

fi
