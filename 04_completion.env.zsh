# Files to ignore during completion
fignore=(DS_Store $fignore)

setopt correct         # Enable Corrections
setopt correctall      # Always Make Suggestions
setopt numericglobsort # Sort filenames numerically when it makes sense
setopt extendedglob    # Extended globbing. Allows using regular expressions with *
setopt nocaseglob
setopt always_to_end # Move cursor to end if word had one match

autoload -Uz compinit

typeset -i updated_at=$(
    date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null
)

if [ $(date +'%j') != $updated_at ]; then
    compinit -i
else
    compinit -C -i
fi

zmodload -i zsh/complist

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
#compdef _changie changie

# zsh completion for changie                              -*- shell-script -*-

__changie_debug()
{
    local file="$BASH_COMP_DEBUG_FILE"
    if [[ -n ${file} ]]; then
        echo "$*" >> "${file}"
    fi
}

_changie()
{
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16
    
    local lastParam lastChar flagPrefix requestComp out directive comp lastComp noSpace
    local -a completions
    
    __changie_debug "\n========= starting completion logic =========="
    __changie_debug "CURRENT: ${CURRENT}, words[*]: ${words[*]}"
    
    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $CURRENT location, so we need
    # to truncate the command-line ($words) up to the $CURRENT location.
    # (We cannot use $CURSOR as its value does not work when a command is an alias.)
    words=("${=words[1,CURRENT]}")
    __changie_debug "Truncated words[*]: ${words[*]},"
    
    lastParam=${words[-1]}
    lastChar=${lastParam[-1]}
    __changie_debug "lastParam: ${lastParam}, lastChar: ${lastChar}"
    
    # For zsh, when completing a flag with an = (e.g., changie -n=<TAB>)
    # completions must be prefixed with the flag
    setopt local_options BASH_REMATCH
    if [[ "${lastParam}" =~ '-.*=' ]]; then
        # We are dealing with a flag with an =
        flagPrefix="-P ${BASH_REMATCH}"
    fi
    
    # Prepare the command to obtain completions
    requestComp="${words[1]} __complete ${words[2,-1]}"
    if [ "${lastChar}" = "" ]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go completion code.
        __changie_debug "Adding extra empty parameter"
        requestComp="${requestComp} \"\""
    fi
    
    __changie_debug "About to call: eval ${requestComp}"
    
    # Use eval to handle any environment variables and such
    out=$(eval ${requestComp} 2>/dev/null)
    __changie_debug "completion output: ${out}"
    
    # Extract the directive integer following a : from the last line
    local lastLine
    while IFS='\n' read -r line; do
        lastLine=${line}
    done < <(printf "%s\n" "${out[@]}")
    __changie_debug "last line: ${lastLine}"
    
    if [ "${lastLine[1]}" = : ]; then
        directive=${lastLine[2,-1]}
        # Remove the directive including the : and the newline
        local suffix
        (( suffix=${#lastLine}+2))
        out=${out[1,-$suffix]}
    else
        # There is no directive specified.  Leave $out as is.
        __changie_debug "No directive found.  Setting do default"
        directive=0
    fi
    
    __changie_debug "directive: ${directive}"
    __changie_debug "completions: ${out}"
    __changie_debug "flagPrefix: ${flagPrefix}"
    
    if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
        __changie_debug "Completion received error. Ignoring completions."
        return
    fi
    
    while IFS='\n' read -r comp; do
        if [ -n "$comp" ]; then
            # If requested, completions are returned with a description.
            # The description is preceded by a TAB character.
            # For zsh's _describe, we need to use a : instead of a TAB.
            # We first need to escape any : as part of the completion itself.
            comp=${comp//:/\\:}
            
            local tab=$(printf '\t')
            comp=${comp//$tab/:}
            
            __changie_debug "Adding completion: ${comp}"
            completions+=${comp}
            lastComp=$comp
        fi
    done < <(printf "%s\n" "${out[@]}")
    
    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
        __changie_debug "Activating nospace."
        noSpace="-S ''"
    fi
    
    if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
        # File extension filtering
        local filteringCmd
        filteringCmd='_files'
        for filter in ${completions[@]}; do
            if [ ${filter[1]} != '*' ]; then
                # zsh requires a glob pattern to do file filtering
                filter="\*.$filter"
            fi
            filteringCmd+=" -g $filter"
        done
        filteringCmd+=" ${flagPrefix}"
        
        __changie_debug "File filtering command: $filteringCmd"
        _arguments '*:filename:'"$filteringCmd"
        elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
        # File completion for directories only
        local subDir
        subdir="${completions[1]}"
        if [ -n "$subdir" ]; then
            __changie_debug "Listing directories in $subdir"
            pushd "${subdir}" >/dev/null 2>&1
        else
            __changie_debug "Listing directories in ."
        fi
        
        local result
        _arguments '*:dirname:_files -/'" ${flagPrefix}"
        result=$?
        if [ -n "$subdir" ]; then
            popd >/dev/null 2>&1
        fi
        return $result
    else
        __changie_debug "Calling _describe"
        if eval _describe "completions" completions $flagPrefix $noSpace; then
            __changie_debug "_describe found some completions"
            
            # Return the success of having called _describe
            return 0
        else
            __changie_debug "_describe did not find completions."
            __changie_debug "Checking if we should do file completion."
            if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
                __changie_debug "deactivating file completion"
                
                # We must return an error code here to let zsh know that there were no
                # completions found by _describe; this is what will trigger other
                # matching algorithms to attempt to find completions.
                # For example zsh can match letters in the middle of words.
                return 1
            else
                # Perform file completion
                __changie_debug "Activating file completion"
                
                # We must return the result of this command, so it must be the
                # last command, or else we must store its result to return it.
                _arguments '*:filename:_files'" ${flagPrefix}"
            fi
        fi
    fi
}

# don't run the completion function when being source-ed or eval-ed
if [ "$funcstack[1]" = "_changie" ]; then
    _changie
fi

source /usr/share/fzf/completion.zsh
# --------------------------------------------------- #
# --------------------------------------------------- #
# --------------------------------------------------- #
fasd_cache="$HOME/.fasd-init"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
    fasd --init auto >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache