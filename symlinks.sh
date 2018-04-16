#!/usr/bin/sh

#ZSH
ln -s ~/.dotfiles/shells/zsh/zprofile ~/.zprofile
ln -s ~/.dotfiles/shells/zsh/zshrc ~/.zshrc
ln -s ~/.dotfiles/shells/zsh/zshrc ~/.zshrc.pre-oh-my-zsh

#bash
ln -s ~/.dotfiles/shells/bash/bash_profile ~/.bash_profile
ln -s ~/.dotfiles/shells/bash/bashrc ~/.bashrc

#X
ln -s ~/.dotfiles/x/xinitrc ~/.xinitrc

#Git
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig

#i3
mkdir -p ~/.config/i3
ln -s ~/.dotfiles/i3/config ~/.config/i3/config

#vim
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc


