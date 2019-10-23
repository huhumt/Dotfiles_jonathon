# this rg command will get a list of files that are not in gitignore or similar
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="--preview '[[ \$(file -L --mime {}) =~ binary ]] && echo {} is a binary file || ( bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500'"
export FZF_CTRL_R_OPTS="--no-preview"
# this is the argument completeion optionm, use the same command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
if [ -e /usr/share/fzf/key-bindings.zsh ]; then
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh

	# CTRL-W to select a wordlist
	__fsel_wordlist() {
		local cmd="$FZF_DEFAULT_COMMAND --exclude \*.md --exclude \*.gif --exclude \*.jpg --exclude \*.png --exclude \*.lua --exclude \*.jar --exclude \*.pl '' /usr/share/wordlists/ | sed 's#^/usr/share/wordlists/##'"
		setopt localoptions pipefail 2> /dev/null
		eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS --preview 'bat --color=always /usr/share/wordlists/{}'" $(__fzfcmd) -m "$@" | while read item; do
			echo -n "/usr/share/wordlists/${(q)item} "
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
	#zle     -N   fzf-wordlist-widget
	#bindkey '^W' fzf-wordlist-widget

	# CTRL-P to select an IP address from project host
	__fsel_ip() {
		setopt localoptions pipefail 2> /dev/null
		project hosts ip --fzf

		local ret=$?
		return $ret
	}

	fzf-ip-widget() {
		LBUFFER="${LBUFFER}$(project hosts ip --fzf) "
		local ret=$?
		zle reset-prompt
		return $ret
	}
	#zle     -N   fzf-ip-widget
	#bindkey '^P' fzf-ip-widget


	# I want my tab complete to be based on "current" word I am typing sometimes, before the command
	custom_tabcomplete(){
		local tokens cmd prefix trigger tail fzf matches lbuf d_cmds
		setopt localoptions noshwordsplit noksh_arrays noposixbuiltins

		# http://zsh.sourceforge.net/FAQ/zshfaq03.html
		# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags
		tokens=(${(z)LBUFFER})
		if [ ${#tokens} -lt 1 ]; then
			zle ${fzf_default_completion:-expand-or-complete}
			return
		fi
		cmd=${tokens[1]}
		tail=${LBUFFER:$(( ${#LBUFFER} - ${#trigger} ))}
		local currentProject=$(project current --path)
		#local newLBuffer="${tokens:1:${#tokens[@]}-1}"
		local newLBuffer
		for i in $(seq 1 $((${#tokens[@]} - 1)) ); do
			newLBuffer="${newLBuffer}${tokens[i]} "
		done
		

		# Some of my completions should only work when in a project
		if [ -n "$currentProject" ]; then
			if [[ "${LBUFFER[-1]}" == " " ]]; then
				fzf-completion
			else
				case "${tokens[-1]}" in
					ip)
						LBUFFER="${newLBuffer}$(project hosts ip --fzf) "
						local ret=$?
						zle reset-prompt
						return $ret
						;;
					pf)
						LBUFFER="${newLBuffer}$(find "$currentProject" -type f | fzf) "
						local ret=$?
						zle reset-prompt
						return $ret
						;;
					pd)
						LBUFFER="${newLBuffer}$(find "$currentProject" -type d | fzf --no-preview) "
						local ret=$?
						zle reset-prompt
						return $ret
						;;
					wl)
						LBUFFER="${newLBuffer}$(__fsel_wordlist)"
						local ret=$?
						zle reset-prompt
						return $ret
						;;
					*)
						# Fall back to fzf completion
						fzf-completion
				esac
			fi
		else
			case "${tokens[-1]}" in
				wl)
					LBUFFER="${newLBuffer}$(__fsel_wordlist)"
					local ret=$?
					zle reset-prompt
					return $ret
					;;
				*)
					# Fall back to fzf completion
					fzf-completion
			esac
		fi
	}
	zle     -N   custom_tabcomplete
	bindkey '^I' custom_tabcomplete



fi
