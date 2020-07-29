fpath=("${ZSH_FOLDER}completion" $fpath)

# Make completion work
autoload -U compinit
zstyle ':completion:*' menu select
## Auto complete with case insenstivity and allowing some characters to be
#forgotten at the start like a .
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Completion style
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description 'Specify %d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

export LISTMAX=-1

zmodload zsh/complist
compinit
#
# Use vim keys in tab complete menu: (thanks Luke Smith: https://github.com/LukeSmithxyz/voidrice/)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

compdef sshrc=ssh

# Vim completion
compdef v=vim
compdef vi=vim

#autoload bashcompinit
#bashcompinit

# Include hidden files in autocomplete:
_comp_options+=(globdots)

function _aliased_with_prefix() {
	shift words
	(( CURRENT-- ))
	_normal
}
compdef _aliased_with_prefix grc
compdef _aliased_with_prefix sudo

#source "$ZSH_FOLDER/plugins/fzf-tab/fzf-tab.zsh"
