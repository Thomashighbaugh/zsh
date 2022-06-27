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
ALWAYS_TO_END
APPEND_HISTORY
AUTO_LIST
AUTO_MENU
AUTO_PARAM_SLASH
AUTO_PUSHD
AUTOCD
AUTOREMOVESLASH
CDABLEVARS
COMPLETE_IN_WORD
COMPLETEINWORD
CORRECT
EXTENDED_GLOB
EXTENDED_HISTORY
GLOB_COMPLETE
GLOBDOTS
HASH_LIST_ALL
HIST_EXPIRE_DUPS_FIRST
HIST_IGNORE_ALL_DUPS
HIST_IGNORE_SPACE
HIST_NO_FUNCTIONS
HIST_REDUCE_BLANKS
HIST_SAVE_NO_DUPS
INC_APPEND_HISTORY
INTERACTIVE_COMMENTS
INTERACTIVECOMMENTS
LONGLISTJOBS
MAGICEQUALSUBST
MAILWARN
MENUCOMPLETE
NO_CASE_GLOB
NO_MENU_COMPLETE
NOBEEP
NOCHECKJOBS
NOFLOWCONTROL
NOHUP
NONOMATCH
NOSHWORDSPLIT
NOTIFY
NUMERIC_GLOB_SORT
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
CORRECT
EQUALS
FLOWCONTROL
NOMATCH
EOF
