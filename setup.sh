#!/usr/bin/env bash

set -e

echo "Starting setup process. Environment information: $(uname -v)."

OVERWRITE=false
if [[ $* =~ "--force" || $* =~ "-f" ]]; then
	echo "This will overwrite the current files. Make sure to backup them."
	OVERWRITE=true
fi

DOTFILES=($(find .  ! "(" -name "*.md" -o -name "*.sh" ")" -type f -not -path  "./.git/*"))
for file in "${DOTFILES[@]}"; do
	echo "Installing $file..."

	TARGET=$PWD/$file
	DESTINATION=~/$file
	if [ $OVERWRITE == true ]; then
		ln -sf $TARGET $DESTINATION
	else
		ln -s $TARGET $DESTINATION
	fi
done

if ! command -v brew &> /dev/null; then
	echo "Homebrew does not seem to be installed. Installing it..."
	yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "Installing dependencies using Homebrew..."
DEPENDENCIES=("git" "node" "pnpm")
for formula in $DEPENDENCIES; do
	echo "Installing $formula"
	brew install $formula
done

echo "Using the new ZSH configuration..."
source ~/.zshrc

echo "Done."
