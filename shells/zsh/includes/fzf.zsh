# this rg command will get a list of files that are not in gitignore or similar
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --color=always --exclude .git --exclude .PlayOnLinux --exclude \"PlayOnLinux\'s virtual drives\""
export FZF_DEFAULT_OPTS="--reverse --ansi --height 40% --bind change:top --bind ctrl-/:toggle-preview"
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

	is_in_git_repo() {
		git rev-parse HEAD > /dev/null 2>&1
	}


	# Files
	_gf() {
		is_in_git_repo || return
		git -c color.status=always status --short . |
			fzf -m --ansi --nth 2..,.. \
			--preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
			cut -c4- | sed 's/.* -> //'
	}

	# Branches
	_gb() {
		is_in_git_repo || return
		git branch -a --color=always | grep -v '/HEAD\s' | sort |
			fzf --ansi --multi --tac --preview-window right:70% \
			--preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
			sed 's/^..//' | cut -d' ' -f1 |
			sed 's#^remotes/##'
	}

	# Tags
	_gt() {
		is_in_git_repo || return
		git tag --sort -version:refname |
			fzf --multi --preview-window right:70% \
			--preview 'git show --color=always {}'
	}

	# Commit
	_gh() {
		is_in_git_repo || return
		git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
			fzf --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
			--header 'Press CTRL-S to toggle sort' \
			--preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
			grep -o "[a-f0-9]\{7,\}"
	}

	# Remote
	_gr() {
		is_in_git_repo || return
		git remote -v | awk '{print $1 "\t" $2}' | uniq |
			fzf --tac \
			--preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
			cut -d$'\t' -f1
	}

	# Stash
	_gs() {
		is_in_git_repo || return
		git stash list | fzf --reverse -d: --preview 'git show --color=always {1}' |
			cut -d: -f1
	}

	join-lines() {
		local item
		while read item; do
			echo -n "${(q)item} "
		done
	}

	bind-git-helper() {
		local c
		for c in $@; do
			eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
			eval "zle -N fzf-g$c-widget"
			eval "bindkey '^g^$c' fzf-g$c-widget"
		done
	}
	bind-git-helper f b t r h s
	unset -f bind-git-helper

	fzf-openapi-widget(){
		if [ -n "$OPENAPI" ] && [ -f "$OPENAPI" ]; then
			server="$(openapi -j "$OPENAPI" servers | fzf -1 --prompt Server)"
			request="$(openapi -j "$OPENAPI" requests | column -t -s $'\t' | fzf -d '  +' --height 90% --preview "openapi -j \"$OPENAPI\" request {2} {1} | jq -C '.'")"
			method="$(echo -n "$request" | awk -F '  +' '{print $1}' | tr 'a-z' 'A-Z')"
			url="$(echo -n "$request" | awk -F '  +' '{print $2}')"

			case "$LBUFFER" in
				http*|https*) LBUFFER+=" $method $server$url" ;;
				curl*) LBUFFER+=" -X $method $server$url" ;;
			esac
			LBUFFER="$(echo -n "$LBUFFER" | sed -E 's/  +/ /g')"
			zle reset-prompt
		fi
	}
	zle -N fzf-openapi-widget
	bindkey '^o' fzf-openapi-widget


fi
