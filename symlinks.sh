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

# A wrapper around ln which will force if necesary
function myLink(){
	if $force; then
		/usr/bin/ln -sf "$1" "$2"
		echo "forced $2 -> $1"
	else
		/usr/bin/ln -s "$1" "$2"
	fi
}

#ZSH
myLink $HOME/.dotfiles/shells/zsh/zprofile $HOME/.zprofile
myLink $HOME/.dotfiles/shells/zsh/zshrc $HOME/.zshrc
myLink $HOME/.dotfiles/shells/zsh/zshrc $HOME/.zshrc.pre-oh-my-zsh

#bash
myLink $HOME/.dotfiles/shells/bash/bash_profile $HOME/.bash_profile
myLink $HOME/.dotfiles/shells/bash/bashrc $HOME/.bashrc

#X
myLink $HOME/.dotfiles/x/xinitrc $HOME/.xinitrc
myLink /home/jonathan/.dotfiles/x/xmodmap $HOME/.Xmodmap

#Git
myLink $HOME/.dotfiles/git/gitconfig $HOME/.gitconfig

#i3
mkdir -p $HOME/.config/i3
myLink $HOME/.dotfiles/i3/config $HOME/.config/i3/config

#i3blocks
myLink $HOME/.dotfiles/i3/i3blocks.conf $HOME/.i3blocks.conf

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

