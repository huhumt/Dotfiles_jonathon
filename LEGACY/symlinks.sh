#!/usr/bin/sh

# Simple shell script to symlink my dotfiles to their place in the system

#whether to use -f when creating symlnk
force=false
#Ask if files should be overiten
read -n1 -p "Do you want to overide files if they exist? [y/N] " answer

#If anser is y or Y then they should be ovewriten
#Anything else and they shouldn't
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
	force=true
fi

echo ""
# A wrapper around ln which will force if necesary
function myLink(){
	if $force; then
		/usr/bin/ln -sf "$1" "$2"
		echo "forced $2 -> $1"
	else
		if [ ! -e "$2" ]; then
			echo "${1} -> ${2}"
			/usr/bin/ln -s "$1" "$2"
		fi
	fi
}

#ZSH
myLink $HOME/.dotfiles/shells/zsh/zprofile $HOME/.zprofile
myLink $HOME/.dotfiles/shells/zsh/zshrc $HOME/.zshrc

#bash
myLink $HOME/.dotfiles/shells/bash/bash_profile $HOME/.bash_profile
myLink $HOME/.dotfiles/shells/bash/bashrc $HOME/.bashrc

#X
myLink $HOME/.dotfiles/x/xinitrc $HOME/.xinitrc
myLink $HOME/.dotfiles/x/xmodmap $HOME/.Xmodmap

#Git
myLink $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig

#i3
mkdir -p $HOME/.config/i3
myLink $HOME/.dotfiles/i3/config $HOME/.config/i3/config
myLink /home/jonathan/.dotfiles/i3/i3exit $HOME/.config/i3/i3exit

#dunst
myLink $HOME/.dotfiles/dunst $HOME/.config/dunst

#vim
myLink $HOME/.dotfiles/vim $HOME/.vim
myLink $HOME/.dotfiles/vim/.vimrc $HOME/.vimrc

#rofi
myLink $HOME/.dotfiles/rofi $HOME/.config/rofi

#Templates
myLink $HOME/.dotfiles/Templates $HOME/Templates

#Pandoc
myLink $HOME/.dotfiles/pandoc $HOME/.pandoc

#Qutebrowser
myLink $HOME/.dotfiles/qutebrowser $HOME/.config/qutebrowser
