
# Auto-quote meta chars in URLs and Git refspecs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic


# Builtin help, triggered with \e-h
autoload -Uz run-help
unalias run-help 2>/dev/null

# Interactive mv
function imv() {
	local src dst
	for src; do
		[[ -e $src ]] || { print -Pu2 "%F{red}%B$src: No such file or directory%b%f"; continue }
		dst=$src
		vared dst
		[[ $src != $dst ]] && mkdir -p $dst:h && mv -n $src $dst
	done
}

# Useful stuff
autoload -Uz age
autoload -Uz zargs
autoload -Uz zcalc

# Avoid duplicates in $PATH
typeset -U PATH pathz