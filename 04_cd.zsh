#!/bin/env zsh
## CD
########################################################################
setopt autocd          # if only directory path is entered, cd there.
setopt autoremoveslash
setopt cdablevars
setopt menucomplete
setopt globdots
unsetopt autoparamslash
setopt rcexpandparam   # Array expansion with parameters

## Change Directories
### https://github.com/mathiasbynens/dotfiles
alias cd.="cd . "
alias cd..="cd .. "
alias cd...="cd ../.. "
alias cd....="cd ../../.. "
alias cd.....="cd ../../../.. "

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'

## User Directory Shortcuts
alias down="cd ~/Downloads"
alias desk="cd ~/Desktop"
alias pic="cd ~/Pictures"
alias home="cd ~ "
