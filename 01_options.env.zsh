#!/bin/env zsh
################################################################################
## Modules #####################################################################
################################################################################
zmodload zsh/zle
zmodload zsh/zpty
zmodload zsh/complist

autoload _vi_search_fix

autoload -Uz compinit
compinit

autoload -Uz colors
colors

zle -N _vi_search_fix
zle -N _sudo_command_line

################################################################################
## Options #####################################################################
################################################################################

while read -r opt; do
  setopt $opt
done <<-EOF
ALLEXPORT
AUTO_LIST
AUTO_PARAM_SLASH
AUTO_PUSHD
AUTOCD
AUTOREMOVESLASH
CDABLEVARS
HASH_LIST_ALL
INTERACTIVE_COMMENTS
INTERACTIVECOMMENTS
LONGLISTJOBS
MAGICEQUALSUBST
MAILWARN
MENUCOMPLETE
NOBEEP
NOCHECKJOBS
NOHUP
NONOMATCH
NOSHWORDSPLIT
NOTIFY
PROMPTSUBST
PUSHD_IGNORE_DUPS
PUSHD_MINUS
PUSHDMINUS
PUSHDSILENT
PUSHDTOHOME
RCEXPANDPARAM
RECEXACT
RM_STAR_WAIT
SHARE_HISTORY
EOF

WORDCHARS=${WORDCHARS//\//} # Don't consider certain characters part of the word
typeset -U path cdpath fpath manpath

while read -r opt; do
  unsetopt $opt
done <<-EOF
AUTOPARAMSLASH
BGNICE
EQUALS
FLOWCONTROL
NOMATCH
EOF
