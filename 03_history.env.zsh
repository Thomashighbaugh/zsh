autoload -U history-search-end

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

while read -r opt; do
    setopt $opt

done <<-EOF
 EXTENDED_HISTORY     
 HIST_EXPIRE_DUPS_FIRST 
 HIST_FIND_NO_DUPS
 HIST_FIND_NO_DUPS  
 HIST_NO_FUNCTIONS
 HIST_IGNORE_ALL_DUPS
 HIST_IGNORE_SPACE  
 HIST_REDUCE_BLANKS 
 HIST_SAVE_NO_DUPS
 HIST_VERIFY        
 HIST_VERIFY            
 INC_APPEND_HISTORY 
 SHARE_HISTORY   
 SHARE_HISTORY      
EOF

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# search/up one line
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

autoload -U history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#8b9cbe'
fi
