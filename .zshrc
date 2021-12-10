[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh

export GPG_TTY=$(tty)
export PROMPT="%B%F{26}%n@%m %1~ %#%f%b "
export SBIN_PATH="/usr/local/sbin"

if [ $(uname) = "Darwin" ]; then
	export VSCODE_CLI=":/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

export PATH="$PATH:$SBIN_PATH$VSCODE_CLI"

[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
