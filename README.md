# My Dotfiles

Use as you wish. Any code / scripts I have borrowed from other places should be credited in comments in the file. I currently use a [fork of DWM](https://github.com/Jab2870/dwm) as my window manager on Arch Linux, however, I don't think there is anything that is Arch specific.

My primary editor is vim, who's config is in a submodule because I often need to deploy my vim configuration but don't need to download all of my dotfiles.

I use [GNU Stow](https://www.gnu.org/software/stow/) to deploy my dotfiles. There is a helper script in the root of this directory called install.sh that runs the necessary stow commands.

Each folder contains the configuration related to a program / tool. In most cases, this folder is stowed meaning all of it's contents are symlinked to the same place in my $HOME directory. However, there are instances (only shells/zsh at the moment) when I don't want the whole directory to be symlinked. If the directory contains a sub-directory called `STOW`, only the `STOW` directory is stowed.

The folder `LEGACY` is for things that I no longer use but might be of interest if you are the sort of person who likes looking at other people's dotfiles.

The folder `NOSTOW` is for things that I don't manage with stow. This includes a submodule for my DWM fork and configuration files that live outside my home directory.
