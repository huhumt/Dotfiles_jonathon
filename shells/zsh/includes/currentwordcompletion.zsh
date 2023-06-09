# This file provides my current word completion
# Unlike standard completion provided by zsh, this completion is based on the current word rather than the current command





# Prompts the user to select a wordlist from the wordlists folder
wordlistSelect() {
	fd -a --type f --hidden --follow --color=always --exclude .git --exclude \*.md --exclude \*.gif --exclude \*.jpg --exclude \*.png --exclude \*.lua --exclude \*.jar --exclude \*.pl '' /usr/share/wordlists/ | fzf --preview 'bat --color=always {}'
}

regexSelect(){
	(
		echo -e "Name\tRegex\tNotes"

		echo -ne "IP Address\t"
		echo -n '(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])'
		echo -e "\tRequires extended regex -E in grep"

		echo -ne "URLs\t"
		echo -n 'https?://[^\"\\'"'"'> ]+'
		echo -e "\tRequires extended regex -E in grep"

		echo -ne "AWS Keys\t"
		echo -n '([^A-Z0-9]|^)(AKIA|A3T|AGPA|AIDA|AROA|AIPA|ANPA|ANVA|ASIA)[A-Z0-9]{12,}'
		echo -e "\tRequires extended regex -E in grep"

	) | column -t -s $'\t' | fzf --preview-window top:1 --preview 'echo {3}' --delimiter '  +' --header-lines 1 --with-nth 1,2 | awk -F '  +' '{print "\"" $2 "\""}'
}

word_replace(){
	local ret=1
	local word="$1"
	local cmd="$2"
	case "$word" in
		wl) wordlistSelect; return 0 ;;
		myip) ip route | grep -oE '(dev|src) [^ ]+' | sed 'N;s/\n/,/;s/src //;s/dev //' | awk -F',' '{print $2 " " $1}' | sort -u | fzf -1 --no-preview | cut -d' ' -f1; return 0 ;;
		regex) regexSelect; return 0 ;;
	esac
	return "$ret"
}

currentwordcomplete(){
	local tokens cmd swap ret=1 lastWord
	# http://zsh.sourceforge.net/FAQ/zshfaq03.html
	# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags

	# Use zsh's shell parsing to split lbuffer into items
	# This takes into account quoting and escaping
	tokens=(${(z)LBUFFER})

	# If there isn't anythng typed, fall back to old tab binding
	if [ ${#tokens} -lt 1 ]; then
		zle ${currentword_default_completion:-expand-or-complete}
		return
	fi

	# Assume the first element
	# TODO: make this work for multiple commands chained with | or > or && etc.
	# TODO: make this work when command prepended with variables eg a=2 foo bar
	# 			foo is the command name
	cmd="${tokens[1]}"
	lastWord="${tokens[-1]}" 

	# Check we haven't pushed space
	if [ "${LBUFFER[-1]}" != " " ]; then
		swap="$(word_replace "$lastWord" "$cmd")"
		ret="$?"

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
	fi


	if [ "$ret" -eq "0" ]; then
		if [ -n "$swap" ]; then
			tokens[-1]="$swap"
			LBUFFER="${tokens[@]}"
		fi
		zle reset-prompt
		return 0
	else
		zle ${currentword_default_completion:-expand-or-complete}
		return
	fi
}

# Record what ctrl+i is currently set to
# That way we can call it if jhcompletion doesn't result in anything
[ -z "$currentword_default_completion" ] && {
	binding=$(bindkey '^I')
	[[ $binding =~ 'undefined-key' ]] || currentword_default_completion=$binding[(s: :w)2]
	unset binding
}
zle     -N   currentwordcomplete
bindkey '^I' currentwordcomplete



