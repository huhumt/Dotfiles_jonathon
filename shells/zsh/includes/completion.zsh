fpath=("${ZSH_FOLDER}completion" $fpath)

# Make completion work
autoload -U compinit
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
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


#source "$ZSH_FOLDER/plugins/fzf-tab/fzf-tab.zsh"
