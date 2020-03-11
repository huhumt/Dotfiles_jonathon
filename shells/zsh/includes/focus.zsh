#Gain focus
gain_focus(){
	export HASFOCUS="true"
	set_prompts
	zle reset-prompt
}
zle -N gain_focus
bindkey '\033[I' gain_focus # Gain Focus

loose_focus(){
	export HASFOCUS="false"
	set_prompts
	zle reset-prompt
}
zle -N loose_focus
bindkey '\033[O' loose_focus # Loose Focus

# Stop terminal from sending focus events before a process runs
# This eliviates the issue of getting weird characters when a read (or similar) prompt is visible
dont_listen_for_focus(){
	printf '\033[?1004l'
}
add-zsh-hook preexec dont_listen_for_focus

# Make the terminal send focus events again when the prompt is being drawn
# This almost works, although, if a long running process finishes in the background, that terminal will still look like it has focus
listen_for_focus(){
	# This makes sc (and maybe other terminals?) send escape codes to the shell when focus is gained / lost
	printf '\033[?1004h'
}
add-zsh-hook precmd listen_for_focus

HASFOCUS="true"
