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

#echo -e "Please don't sabotage my computer while I'm away \n\nTo turn on the print server, run the command 'cups'\n\nTo update 3d party plugins, run command 'u3p'" | /usr/bin/cowsay -f tux -W 80
