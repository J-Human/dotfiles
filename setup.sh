#!/bin/sh

DOTFILES=(".gitconfig" ".vuerc" ".vimrc")

echo "Starting setup process. Environment information: $(uname -v)"

for file in "${DOTFILES[@]}"; do
	if [ ! -f ~/$file ]
	then
		echo "Installing $file"
		ln -s $PWD/$file ~/$file
	else
		echo "Skipping symlinking process for $file, file exists."
	fi
done
