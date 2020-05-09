# this rg command will get a list of files that are not in gitignore or similar
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --color=always --exclude .git --exclude .PlayOnLinux --exclude \"PlayOnLinux\'s virtual drives\""
export FZF_DEFAULT_OPTS="--reverse --ansi --height 40%"
export FZF_CTRL_R_OPTS=""
# this is the argument completeion optionm, use the same command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --ansi --preview \"bat --style=numbers --color=always {}\""
#export FZF_COMPLETION_TRIGGER=''

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

	_fzf_complete_yay(){
		local tokens=(${(z)LBUFFER})
		if [ "${tokens[-1]}" = "-S" -a "${LBUFFER[-1]}" = " " ]; then
			notify-send "complete"
		fi
		return 1
	}




















fi
