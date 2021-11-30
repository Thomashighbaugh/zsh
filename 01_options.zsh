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

################################################################################
## Options #####################################################################
################################################################################

setopt notify
setopt allexport
setopt auto_menu # Automatically use menu completion
setopt menucomplete
setopt always_to_end # Move cursor to end if word had one match
setopt pushdtohome
setopt recexact
setopt pushdsilent
setopt autopushd
setopt pushdminus
setopt rcquotes


setopt nocheckjobs # Don't warn about running processes when exiting
setopt longlistjobs
setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern


setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
setopt longlistjobs    # Case insensitive globbing
setopt auto_list     # Automatically list choices on ambiguous completion

unsetopt bgnice
###########################################################################
####################################################################
###########################################################################