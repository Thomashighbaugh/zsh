autoload -U history-search-end



HISTFILE=~/.history/zsh_history
HISTSIZE=10500
SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups



setopt hist_ignore_all_dups # Remove older duplicate entries from history
setopt hist_reduce_blanks # Remove superfluous blanks from history items
setopt inc_append_history # Save history entries as soon as they are entered
setopt share_history # Share history between different instances of the shell

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# search/up one line
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
