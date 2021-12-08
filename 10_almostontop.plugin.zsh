## Based on   https://github.com/swirepe/alwaysontop
CLEAR_VERSION=0.6.0

if [ "x$ALMOSONTOP" = "xfalse" ]; then
  # doing nothing here
else
  ALMOSONTOP=true
fi

if [ "$CLEAR_COLOR" = "" ]; then
  CLEAR_COLOR="green"
fi

function _accept_line_clear {
  if [ "x$ALMOSONTOP" = "xtrue" ]; then
    # 1. put cursor to the top of the screen
    tput cup 0 0
    # 2. redraw line with prompt and command (with highlighted text as well)
    zle redisplay
  fi
  zle .accept-line
}

zle -N accept-line _accept_line_clear

function clear
{
  # Help message if there no args
  if [ $# -eq 0 ]; then
    clear_usage
  fi

  local arg=$1
  if [ "x$arg" = "xon" ]; then
    ALMOSONTOP=true
  fi

  if [ "x$arg" = "xoff" ]; then
    ALMOSONTOP=false
  fi

  if [ "x$arg" = "xtoggle" ]; then
    clear_toggle
  fi
}

function clear_toggle
{
  if [ "x$ALMOSONTOP" = "xtrue" ]; then
    clear off
  else
    clear on
  fi
}

# Create widget so it could be bound with keys
zle -N clear_toggle clear_toggle

# "ctrl-X ctrl-L" to toggle clear, alike "ctrl-L" to clear screen
bindkey "^X^L" clear_toggle

function clear_usage
{
  cat <<-EOF
Usage: clear <command>

Commands:
  on     Enables clear plugin
  off    Disables clear plugin
  toggle Toggles clear plugin

Description:
  clear clears previous command output every time before new command
  executed in shell. Insipred by 'alwaysontop' plugin for bash:


Version: $CLEAR_VERSION
EOF
}
