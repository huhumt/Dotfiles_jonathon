#Gain focus

gain_focus(){
	export HASFOCUS="true"
	set_prompts
	zle reset-prompt
}
zle -N gain_focus

loose_focus(){
	export HASFOCUS="false"
	set_prompts
	zle reset-prompt
}
zle -N loose_focus


# This makes sc (and maybe other terminals?) send escape codes to the shell when focus is gained / lost
printf '\033[?1004h'
bindkey '\033[I' gain_focus # Gain Focus
bindkey '\033[O' loose_focus # Loose Focus
HASFOCUS="true"
