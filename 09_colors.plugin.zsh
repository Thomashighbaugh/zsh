## Inspired by Christian Ludwig's 256-colors-plugin
## https://github.com/chrissicool/zsh-256color
###########################################################################
###########################################################################
###########################################################################
_zsh_256color_debug()
{
	[[ -n "${ZSH_256COLOR_DEBUG}" ]] && echo "zsh-256color: $@" >&2
}
###########################################################################
###########################################################################
###########################################################################
_zsh_terminal_set_256color()
{
	if [[ "$TERM" =~ "-256color$" ]] ; then
		_zsh_256color_debug "256 color terminal already set."
		return
	fi
###########################################################################
###########################################################################
###########################################################################
	local TERM256="${TERM}-256color"
###########################################################################
###########################################################################
###########################################################################
	# Use (n-)curses binaries, if installed.
	if [[ -x "$( which toe )" ]] ; then
		if toe -a | egrep "^$TERM256" >/dev/null ; then
			_zsh_256color_debug "Found $TERM256 from (n-)curses binaries."
			export TERM="$TERM256"
			return
		fi
	fi
###########################################################################
###########################################################################
###########################################################################
	# Search through termcap descriptions, if binaries are not installed.
	for termcaps in $TERMCAP "$HOME/.termcap" "/etc/termcap" "/etc/termcap.small" ; do
		if [[ -e "$termcaps" ]] && egrep -q "(^$TERM256|\|$TERM256)\|" "$termcaps" ; then
			_zsh_256color_debug "Found $TERM256 from $termcaps."
			export TERM="$TERM256"
			return
		fi
	done
###########################################################################
###########################################################################
###########################################################################
	# Search through terminfo descriptions, if binaries are not installed.
	for terminfos in $TERMINFO "$HOME/.terminfo" "/etc/terminfo" "/lib/terminfo" "/usr/share/terminfo" ; do
		if [[ -e "$terminfos"/$TERM[1]/"$TERM256" || \
				-e "$terminfos"/"$TERM256" ]] ; then
			_zsh_256color_debug "Found $TERM256 from $terminfos."
			export TERM="$TERM256"
			return
		fi
	done
}
###########################################################################
###########################################################################
###########################################################################
_zsh_terminal_set_256color
unset -f _zsh_terminal_set_256color
unset -f _zsh_256color_debug
###########################################################################
###########################################################################
###########################################################################

# Standarized $0 handling, following:
# https://github.com/zdharma/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

if [[ $PMSPEC != *b* ]] {
  PATH=$PATH:"${0:h}/bin"
}

DEPENDENCES_ARCH+=( grc )
DEPENDENCES_DEBIAN+=( grc )

export LESS="$LESS -R -M"

function ip() {
  command ip --color=auto "$@"
}

function grep() {
  command grep --colour=auto "$@"
}

function egrep() {
  command egrep --colour=auto "$@"
}

function fgrep() {
  command fgrep --colour=auto "$@"
}

if (( $+commands[diff-so-fancy] )); then
  function diff() {
    command diff "$@" | diff-so-fancy
  }
elif (( $+commands[delta] )); then
  function diff() {
    command diff "$@" | delta
  }
else
  function diff() {
    command diff --color "$@"
  }
fi

if (( $+commands[grc] )); then
  function env() {
    command grc --colour=auto env "$@"
  }

  function lsblk() {
    command grc --colour=auto lsblk "$@"
  }

  function df() {
    command grc --colour=auto df -h "$@"
  }

  function du() {
    command grc --colour=auto du -h "$@"
  }

  function free() {
    command grc --colour=auto free -h "$@"
  }

  function as() {
    command grc --colour=auto as "$@"
  }

  if (( $+commands[dig] )); then
    function dig() {
      command grc --colour=auto dig "$@"
    }
  fi

  if (( $+commands[gas] )); then
    function gas() {
      command grc --colour=auto gas "$@"
    }
  fi

  if (( $+commands[gcc] )); then
    function gcc() {
      command grc --colour=auto gcc "$@"
    }
  fi

  if (( $+commands[g++] )); then
    function "g++"(){
      command grc --colour=auto g++ "$@"
    }
  fi

  if (( $+commands[last] )); then
    function last() {
      command grc --colour=auto last "$@"
    }
  fi

  if (( $+commands[ld] )); then
    function ld() {
      command grc --colour=auto ld "$@"
    }
  fi

  if (( $+commands[ifconfig] )); then
    function ifconfig() {
      command grc --colour=auto ifconfig "$@"
    }
  fi

  if (( $+commands[mount] )); then
    function mount() {
      command grc --colour=auto mount "$@"
    }
  fi

  if (( $+commands[mtr] )); then
    function mtr() {
      command grc --colour=auto mtr "$@"
    }
  fi

  if (( $+commands[netstat] )); then
    function netstat() {
      command grc --colour=auto netstat "$@"
    }
  fi

  if (( $+commands[ping] )); then
    function ping() {
      command grc --colour=auto ping "$@"
    }
  fi

  if (( $+commands[ping6] )); then
    function ping6() {
      command grc --colour=auto ping6 "$@"
    }
  fi

  if (( $+commands[ps] )); then
    function ps() {
      command grc --colour=auto ps "$@"
    }
  fi

  if (( $+commands[traceroute] )); then
    function traceroute() {
      command grc --colour=auto traceroute "$@"
    }
  fi
else
  function df() {
    command df -h "$@"
  }

  function du() {
    command du -h "$@"
  }

  function free() {
    command free -h "$@"
  }
fi


