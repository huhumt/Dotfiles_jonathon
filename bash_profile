#
# ~/.bash_profile
#


[[ -f ~/.bashrc ]] && . ~/.bashrc



export TERMINAL=/usr/bin/konsole
export TERM=xterm-256color
export PATH=~/.bin:$PATH:/opt/lampp/bin:.
export EDITOR='vim --servername jab2870'
export CDPATH=.:~:~/Sites

#Ruby things
GEM_HOME=$(ls -t -U | ruby -e 'puts Gem.user_dir')
GEM_PATH=$GEM_HOME
export PATH=$PATH:$GEM_HOME/bin
export GEM_HOME=$(ruby -e 'print Gem.user_dir')


# tab completion for ssh hosts
complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,\s]+/)[1..-1].reject{|host| host.match(/\*|\?/)} if $_.match(/^\s*Host\s+/);' < $HOME/.ssh/config)" scp sftp ssh

#echo -e "Please don't sabotage my computer while I'm away \n\nTo turn on the print server, run the command 'cups'\n\nTo update 3d party plugins, run command 'u3p'" | /usr/bin/cowsay -f tux -W 80


[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config
