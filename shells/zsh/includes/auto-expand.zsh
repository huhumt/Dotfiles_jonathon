#!/usr/bin/env zsh

# An array of aliases that should be auto-expanded
typeset -a ealiases
ealiases=(
	"mkdir"
	"qmv"
	"grep"
	"cal"
	"df"
	"docker"
	"docker-compose"
	"v"
	"vim"
	"status"
	"st"
	"checkout"
	"ch"
	"push"
	"pull"
	"bb"
	"merge"
	"mg"
	"switch"
	"sw"
)





# expand any aliases in the current line buffer
function expand-ealias() {
    if [[ $LBUFFER =~ "\<(${(j:|:)ealiases})\$" ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle magic-space
}
zle -N expand-ealias

# Bind the space key to the expand-alias function above, so that space will expand any expandable aliases
bindkey ' '        expand-ealias
bindkey '^ '       magic-space     # control-space to bypass completion
bindkey -M isearch " "      magic-space     # normal space during searches

# A function for expanding any aliases before accepting the line as is and executing the entered command
expand-alias-and-accept-line() {
    expand-ealias
    zle .backward-delete-char
    zle .accept-line
}
zle -N accept-line expand-alias-and-accept-line
