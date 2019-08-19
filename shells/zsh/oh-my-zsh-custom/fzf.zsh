# this rg command will get a list of files that are not in gitignore or similar
export FZF_DEFAULT_COMMAND="rg --files"
# this is the argument completeion optionm, use the same command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
if [ -e /usr/share/fzf/key-bindings.zsh ]; then
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
fi
