source "$ZSH_FOLDER/plugins/zsh-auto-notify/auto-notify.plugin.zsh"
export AUTO_NOTIFY_THRESHOLD=5
export AUTO_NOTIFY_TITLE="Hey! %command has just finished"
export AUTO_NOTIFY_BODY="It completed in %elapsed seconds with exit code %exit_code"
AUTO_NOTIFY_IGNORE+=("bat" "cat" "zathura" "libreoffice" "lf" "davmail" "neomutt" "newsboat" "w3m" "sl")
