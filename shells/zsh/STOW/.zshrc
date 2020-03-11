# Make colours work
#
autoload -U colors && colors

# Make sure we are using vi mode
bindkey -v

# History in cache directory:
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_SPACE
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

export KEYTIMEOUT=25

# Change cursor shape for different vi modes. (thanks Luke Smith: https://github.com/LukeSmithxyz/voidrice/)
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
#
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne '\e[5 q'
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

bindkey -v '^?' backward-delete-char


if [ ! -n "$SSH_CLIENT" ] && [ ! -n "$SSH_TTY" ]; then
	if [ -L $DOTFILES/shells/zsh/current-color-scheme ]; then
		source $DOTFILES/shells/zsh/current-color-scheme
	fi
fi

TRAPWINCH(){
	zle && {zle reset-prompt; zle -R}
}

setopt autocd

# I use initial command in my folder-shell script
# This is normally empty, but might be lf or ranger if I want to open it
# THis is almost always a curses app so I don't want to try and record the terminal
if [ -n "$initialCommand" ]; then
	echo "Running $initialCommand"
	$initialCommand && exit
else
	local current="$(project current --path)"
	if [ -n "$current" ]; then
		local script="/usr/bin/script"
		if [[ ! "$(ps -ocommand -p $PPID | grep -v 'COMMAND' | cut -d' ' -f1 )" == "$script" ]]; then
			mkdir "$current/shell-logs" 2> /dev/null
			/usr/bin/script -f "$current/shell-logs/$(date +"%d-%b-%y_%H-%M-%S")_shell.log"
		fi
	fi
fi

export ZSH_FOLDER="$DOTFILES/shells/zsh/"
# Include my config files
for file in "$ZSH_FOLDER/includes/"*".zsh"; do
	source "$file"
done

# Load zsh-syntax-highlighting; should be last.
source $HOME/.dotfiles/shells/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
