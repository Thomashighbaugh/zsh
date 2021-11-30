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

