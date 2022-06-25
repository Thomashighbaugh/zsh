# Files to ignore during completion
fignore=(DS_Store $fignore)

setopt correct         # Enable Corrections
setopt correctall      # Always Make Suggestions
setopt numericglobsort # Sort filenames numerically when it makes sense
setopt extendedglob    # Extended globbing. Allows using regular expressions with *
setopt nocaseglob
setopt always_to_end   # Move cursor to end if word had one match
unsetopt menu_complete # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu # show completion menu on succesive tab press
autoload -Uz compinit
zle
zmodload -i zsh/complist
if [ -f "/usr/share/fzf/completion.zsh" ]; then
    source /usr/share/fzf/completion.zsh
fi
typeset -i updated_at=$(
    date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null
)

if [ $(date +'%j') != $updated_at ]; then
    compinit -i
else
    compinit -C -i
fi

################################################################################
## Completion Styles ###########################################################
################################################################################

zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

## list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

## insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

## formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

## match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
    admb apache bin daemon games gdm halt ident junkbust lp mail mailnull \
    named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail firebird gnats haldaemon hplip irc klog list man cupsys postfix proxy syslog www-data mldonkey sys snort

zstyle ':completion:*' rehash true # automatically find new executables in path

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcache
compdef _changie changie

# --------------------------------------------------- #
# --------------------------------------------------- #
# --------------------------------------------------- #
fasd_cache="$HOME/.fasd-init"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >|"$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' completer _oldlist _expand

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'

# Have the newer files last so I see them first
#zstyle ':completion:*' file-sort modification reverse

# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*' list-separator '»»'

# complete with a menu for xwindow ids
zstyle ':completion:*:windows' menu on=0
zstyle ':completion:*:expand:*' tag-order all-expansions

# Errors format
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'

# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true

# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd

# make kill way awesome
zstyle ':completion:*:processes' command 'ps -au$USER -o pid,time,cmd|grep -v "ps -au$USER -o pid,time,cmd"'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)[ 0-9:]#([^ ]#)*=01;30=01;31=01;38'

zstyle ':completion:*:*:git:*' script ~/code/git/contrib/completion/git-completion.bash

# load bash completions too
autoload -U +X bashcompinit && bashcompinit
