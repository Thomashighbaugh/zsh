################################################################################
## Options #####################################################################
################################################################################

setopt notify
setopt allexport

setopt auto_menu     # Automatically use menu completion
setopt always_to_end # Move cursor to end if word had one match


setopt pushdtohome


setopt recexact

setopt pushdsilent
setopt autopushd
setopt pushdminus
setopt rcquotes



setopt nocheckjobs     # Don't warn about running processes when exiting
# if only directory path is entered, cd there.

## Personal Email ##############################################################
export EMAIL="thighbaugh@zoho.com"

export TERMINAL="kitty"
export TERM=xterm-256color
export VISUAL="nvim"
export BROWSER="firefox"
export ALT_BROWSER="chromium"
export EMAIL="thunderbird"
export GUIFM="thunar"
export PASSWD="keepassxc"
export LAUNCHER='rofi  -show drun -theme ~/.config/awesome/configuration/appmenu.rasi'
export MOZ_X11_EG=1


# OS ##############################################################
export OS=$(uname -s)
export ARCH=$(uname -m)
## DATE  ###########################################################
DATE=$(date +%s)
export DATE
