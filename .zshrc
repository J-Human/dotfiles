export GPG_TTY=$(tty)
export PROMPT="%B%F{26}%n@%m %1~ %#%f%b "

if [ $(uname) = "Darwin" ]; then
	export VSCODE_CLI=":/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

export PATH="$PATH$VSCODE_CLI"
