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
DEPENDENCIES=("clang-format" "cocoapods" "gcc" "git" "neovim" "node" "pnpm")
for formula in $DEPENDENCIES; do
	echo "Installing $formula"
	brew install $formula
done

if [ $(uname) = "Darwin" ]; then
	echo "Installing apps using Homebrew..."
	APPS=(
		"android-studio"
		"battle-net"
		"discord"
		"fig"
		"google-chrome"
		"visual-studio-code"
		"zoom"
	)
	for formula in $APPS; do
		echo "Installing $formula"
		brew install --cask $formula
	done

	echo "Installing various macOS system preferences..."
	sudo nvram StartupMute=%00
	defaults write com.apple.finder QuitMenuItem -bool true
	defaults write com.apple.dt.Xcode "ShowBuildOperationDuration" -bool true
	defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0.0"
	defaults write NSGlobalDomain "AppleShowAllExtensions" -bool true
	killall Finder || true
	killall Xcode || true
else
	echo "Skipping installing apps, and system configuration on non-macOS system. Found $(uname)."
fi

echo "Using the new ZSH configuration..."
source ~/.zshrc

echo "Done."
