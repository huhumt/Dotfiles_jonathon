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
