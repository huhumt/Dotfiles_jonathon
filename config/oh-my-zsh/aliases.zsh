# These alow me to easily set the file and folder permissions for a wordpress instilation.
alias folder-perms='find . -type d -not -path "./.git/*" -not -path "./.git" -exec chmod 775 {} \;'
alias file-perms='find . -type f -not -path "./.git/*" -not -path "./.git" -exec chmod 664 {} \;'
alias wp-perms='folder-perms; file-perms'
alias magentoPerms='cd ${PWD%/public_html*}/public_html;sudo chown -R jonathan:http .; folder-perms; file-perms; chmod +x bin/magento; cd -'
alias upgr='magento setup:upgrade && magento setup:di:compile && magentoPerms'
                       #
# Make ls add Indicator#s to file names and colour the output
alias ls='ls -F --color=auto'

# Make tree add indicators and color
alias tree='tree -F -C'

#Start cups
alias cups='sudo systemctl start org.cups.cupsd.service'

#Start network manager
alias net='sudo systemctl start NetworkManager.service'

# Alias lampp because I don't want to clog my PATH
alias lampp='/opt/lampp/lampp'
alias glampp='gksudo /opt/lampp/manager-linux-x64.run'
alias php='/opt/lampp/bin/php'
alias php-cgi='/opt/lampp/bin/php-cgi'
alias php-config='/opt/lampp/bin/php-config'

#Always make all directories necesary
alias mkdir='mkdir -p'

# Shortcut for rewriting wp permalinks
alias perms='wp rewrite flush'

#Clear terminal and screenfetch
alias cls='clear; screenfetch'

#An alias for my standard less configuration
#I don't set it to lessc because sometimes I don't use this config and I always forget how to ignore an alias
#alias myless='lessc --clean-css --source-map-basepath=/home/jonathan/Sites/charts/public_html --source-map --autoprefix="last 3 versions, ie >= 9" styles.less styles.min.css'
alias myless='lessc --clean-css --source-map --autoprefix="last 3 versions, ie >= 9" styles.less styles.min.css'

# Git shortcuts
alias status='git status '
alias st='git status'
alias checkout='git checkout'
alias ch='git checkout'
alias push='git push '
alias pull='git pull '
alias bb='git open'

# Always make grep ouput color
alias grep="grep --color=auto"

# Shortcuts to sites folder
alias sites="cd ~/Sites"
alias s="cd ~/Sites"

# Shortcuts to documents folder
alias documents="cd ~/Documents/"
alias d="cd ~/Documents/"

# Shortcuts to documents folder
alias db="cd ~/Dropbox/"

# Shortcuts to home folder
alias home="cd ~/"
alias ~="cd ~/"

#Goes up to the public_html folder
alias ph='cd ${PWD%/public_html*}/public_html'

# Quit the terminal using :q (The same as Vi/Vim)
alias :q='exit;'

# Not sure why and how but this makes sudo work with my aliases
alias sudo='sudo '

#Make the cal command default to start on Sunday
alias cal='cal -s'

# update the third party wordpress plugins we are mirroring
alias u3p='update3rdPartyPlugins'

# Edit my bashrc
alias brc='$EDITOR ~/.bashrc'

# Edit my vimrc
alias vrc='$EDITOR ~/.vimrc'

# Go to my .vim folder
alias .v='cd ~/.vim/'

alias df='cd ~/.dotfiles'

#Make vim start in server mode
alias vim='vim --servername jab2870'

# moon phase
alias moonphase='weather moon'

#Radio Stations
AUDIO=mpv
alias radio2="$AUDIO http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/sbr_med/llnw/bbc_radio_two.m3u8"
alias radio4="$AUDIO http://a.files.bbci.co.uk/media/live/manifesto/audio/simulcast/hls/uk/sbr_med/llnw/bbc_radio_fourfm.m3u8"
alias classic="$AUDIO http://icy-e-bab-04-cr.sharp-stream.com/absoluteradio.mp3"
alias absolute="$AUDIO 'http://network.absoluteradio.co.uk/core/audio/mp3/live.pls?service=vrbb'"

alias bs="curl -s http://cbsg.sourceforge.net/cgi-bin/live | grep -Eo '^<li>.*</li>' | sed -r -e 's/<\/?li>//g' | shuf -n 1 | cowsay"

alias jq="jq -C"

alias debugBuild='node --inspect-brk /usr/bin/grunt build'

alias lc="colorls -r"

alias open="$TERMINAL & disown"

# Fix Typos
alias cim="vim"
