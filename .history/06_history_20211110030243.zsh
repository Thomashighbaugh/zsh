autoload -U history-search-end

HISTFILE=~/.zsh_history
HISTSIZE=10500
SAVEHIST=20000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups

setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_verify            # show command with history expansion to user before running it

setopt hist_ignore_all_dups # Remove older duplicate entries from history
setopt hist_reduce_blanks   # Remove superfluous blanks from history items
setopt inc_append_history   # Save history entries as soon as they are entered
setopt share_history        # Share history between different instances of the shell

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# search/up one line
 autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
 zle -N up-line-or-beginning-search
 zle -N down-line-or-beginning-search

#autoload -U history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

