#
# dotzsh : https://github.com/dotphiles/dotzsh
#
# Sets general shell options and defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Ben O'Hara <bohara@gmail.com>
#

# General
setopt BRACE_CCL      # Allow brace character class list expansion.
setopt RC_QUOTES      # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt MAIL_WARNING # Don't print a warning message if a mail file has been accessed.
HOSTNAME=$(cat /etc/hostname)
ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')

if [ -f /etc/lsb-release ]; then
  . /etc/lsb-release
  OS=$DISTRIB_ID
  OSVER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
  OS=Debian # XXX or Ubuntu??
  OSVER=$(cat /etc/debian_version)
elif [ -f /etc/redhat-release ]; then
  OS=RedHat
  OSVER=$(cat /etc/redhat-release | awk '{print $3}')
else
  OS=$(uname -s)
  OSVER=$(uname -r)
fi
OSMAJORVER=$(echo $OSVER | awk -F"." '{print $1}')

# Jobs
setopt LONG_LIST_JOBS # List jobs in the long format by default.
setopt AUTO_RESUME    # Attempt to resume existing job before creating a new process.
setopt NOTIFY         # Report status of background jobs immediately.
unsetopt BG_NICE      # Don't run all background jobs at a lower priority.
unsetopt HUP          # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS   # Don't report on jobs when shell exit.

# Grep
if zstyle -t ':dotzsh:module:environment:grep' color; then
  export GREP_OPTIONS='--color=auto'
fi

# Set the PAGER
zstyle -s ':dotzsh:module:environment' pager 'pager'
export PAGER='less'

# Set the default Less options.
zstyle -b ':dotzsh:module:environment:pager:less' mousescroll '_mousescroll'
if is-true "${_mousescroll}"; then
  export LESS='-g -i -M -R -S -w -z-4'
else
  export LESS='-F -g -i -M -R -S -w -X -z-4'
fi
# Set the Less input preprocessor.

if (($ + commands[src - hilite - lesspipe.sh])); then
  export LESSOPEN='| /usr/bin/env src-hilite-lesspipe.sh %s 2>&-'
elif (($ + commands[lesspipe.sh])); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

export LESSHISTFILE="$HOME/.history/less"

# Termcap
if zstyle -t ':dotzsh:module:environment:termcap' color; then
  export LESS_TERMCAP_mb=$'\E[01;31m'    # Begins blinking.
  export LESS_TERMCAP_md=$'\E[01;31m'    # Begins bold.
  export LESS_TERMCAP_me=$'\E[0m'        # Ends mode.
  export LESS_TERMCAP_se=$'\E[0m'        # Ends standout-mode.
  export LESS_TERMCAP_so=$'\E[00;47;30m' # Begins standout-mode.
  export LESS_TERMCAP_ue=$'\E[0m'        # Ends underline.
  export LESS_TERMCAP_us=$'\E[01;32m'    # Begins underline.
else
  print "dotzsh: invalid pager: $pager" >&2
fi
