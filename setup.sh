#!/bin/bash

DOT_FILES=( .zshrc .fbtermrc .vimrc .xinitrc .xmodmaprc .xsession .zprofile .zshrc)

for file in ${DOT_FILES[@]}
do
	ln -s $HOME/Sources/dotfiles/$file $HOME/$file
done
