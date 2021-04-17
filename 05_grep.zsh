if [[ -x $(which ripgrep) ]]; then
	alias rgrep=$(which ripgrep)
	alias grep='ripgrep --color'
fi
