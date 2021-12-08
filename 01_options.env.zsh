#!/bin/env zsh

################################################################################
## Options #####################################################################
################################################################################
# make cd push the old directory onto the directory stack.
setopt auto_pushd
# avoid "beep"ing
setopt nobeep
# if only directory path is entered, cd there.
setopt autocd
setopt autoremoveslash
setopt cdablevars
setopt menucomplete
setopt globdots
unsetopt autoparamslash
# Array expansion with parameters
setopt rcexpandparam
# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# not just at the end
setopt completeinword

# use zsh style word splitting
setopt noshwordsplit
# allow use of comments in interactive code
setopt interactivecomments

setopt notify
setopt allexport
# Automatically use menu completion
setopt auto_menu
setopt menucomplete
# Move cursor to end if word had one match
setopt always_to_end
setopt pushdtohome
setopt recexact
setopt pushdsilent
setopt pushdminus

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# no c-s/c-q output freezing
setopt noflowcontrol

# Don't warn about running processes when exiting
setopt nocheckjobs
setopt longlistjobs

# auto correct mistakes
setopt correct
# enable filename expansion for arguments of the form ‘anything=expression’
setopt magicequalsubst
# hide error message if there is no match for the pattern
setopt nonomatch
# sort filenames numerically when it makes sense
setopt numericglobsort 
# enable command substitution in prompt
setopt promptsubst     
# Include job PID
setopt longlistjobs   
 # Automatically list choices on ambiguous completion 
setopt auto_list      

unsetopt bgnice
###########################################################################
####################################################################
###########################################################################
