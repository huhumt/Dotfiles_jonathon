# this rg command will get a list of files that are not in gitignore or similar
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || ( bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500'"
# this is the argument completeion optionm, use the same command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
if [ -e /usr/share/fzf/key-bindings.zsh ]; then
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh

	# CTRL-W to select a wordlist
	__fsel_wordlist() {
	  local cmd="$FZF_DEFAULT_COMMAND '' /usr/share/wordlists/"
	  setopt localoptions pipefail 2> /dev/null
	  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
		echo -n "${(q)item} "
	  done
	  local ret=$?
	  echo
	  return $ret
	}

	fzf-wordlist-widget() {
	  LBUFFER="${LBUFFER}$(__fsel_wordlist)"
	  local ret=$?
	  zle reset-prompt
	  return $ret
	}
	zle     -N   fzf-wordlist-widget
	bindkey '^W' fzf-wordlist-widget
fi
