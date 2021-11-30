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
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt


## Prompt ##########################################################
PROMPT_EOL_MARK=""

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset


WORDCHARS=${WORDCHARS//\//} # Don't consider certain characters part of the word
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

configure_prompt() {
    # dogenpunk.zsh-theme
    
    MODE_INDICATOR="%{$fg_bold[red]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"
    local return_status="%{$fg[red]%}%(?..⏎)%{$reset_color%}"
    
    PROMPT='%{$fg[white]%}%m%{$reset_color%}%{$fg[red]$bg[white]%} ॐ  %{$reset_color%}%{$fg[white]%}%~:%{$reset_color%}%{$fg_bold[white]%}%!%{$reset_color%} $(prompt_char) '
    
    ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%}git%{$reset_color%}@%{$bg[white]%}%{$fg[black]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
    ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}!%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
    
    RPROMPT='${return_status}%{$reset_color%}'
    
    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
    
    function prompt_char() {
        git branch >/dev/null 2>/dev/null && echo "%{$fg[green]%}±%{$reset_color%}" && return
        hg root >/dev/null 2>/dev/null && echo "%{$fg_bold[red]%}☿%{$reset_color%}" && return
        echo "%{$fg[white]%}◯ %{$reset_color%}"
    }
    
    # Colors vary depending on time lapsed.
    ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
    ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
    ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
    ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[cyan]%}"
    
    # Determine the time since last commit. If branch is clean,
    # use a neutral color, otherwise colors will vary according to time.
    function git_time_since_commit() {
        if git rev-parse --git-dir >/dev/null 2>&1; then
            # Only proceed if there is actually a commit.
            if git log -n 1 >/dev/null 2>&1; then
                # Get the last commit.
                last_commit=$(git log --pretty=format:'%at' -1 2>/dev/null)
                now=$(date +%s)
                seconds_since_last_commit=$((now - last_commit))
                
                # Totals
                MINUTES=$((seconds_since_last_commit / 60))
                HOURS=$((seconds_since_last_commit / 3600))
                
                # Sub-hours and sub-minutes
                DAYS=$((seconds_since_last_commit / 86400))
                SUB_HOURS=$((HOURS % 24))
                SUB_MINUTES=$((MINUTES % 60))
                
                if [[ -n $(git status -s 2>/dev/null) ]]; then
                    if [ "$MINUTES" -gt 30 ]; then
                        COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
                        elif [ "$MINUTES" -gt 10 ]; then
                        COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
                    else
                        COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
                    fi
                else
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
                fi
                
                if [ "$HOURS" -gt 24 ]; then
                    echo "($COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}|"
                    elif [ "$MINUTES" -gt 60 ]; then
                    echo "($COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%}|"
                else
                    echo "($COLOR${MINUTES}m%{$reset_color%}|"
                fi
            else
                COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
                echo "($COLOR~|"
            fi
        fi
    }
    
}


if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1
    
    configure_prompt
    
    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && [ "$color_prompt" = yes ]; then
        . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        ZSH_HIGHLIGHT_STYLES[default]=none
        ZSH_HIGHLIGHT_STYLES[unknown - token]=fg=red,bold
        ZSH_HIGHLIGHT_STYLES[reserved - word]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[suffix - alias]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[global - alias]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[path]=underline
        ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[history - expansion]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[command - substitution]=none
        ZSH_HIGHLIGHT_STYLES[command - substitution - delimiter]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[process - substitution]=none
        ZSH_HIGHLIGHT_STYLES[process - substitution - delimiter]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[single - hyphen - option]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[double - hyphen - option]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[back - quoted - argument]=none
        ZSH_HIGHLIGHT_STYLES[back - quoted - argument - delimiter]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[single - quoted - argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[double - quoted - argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[dollar - quoted - argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[rc - quote]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[dollar - double - quoted - argument]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[back - double - quoted - argument]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[back - dollar - quoted - argument]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[assign]=none
        ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
        ZSH_HIGHLIGHT_STYLES[named - fd]=none
        ZSH_HIGHLIGHT_STYLES[numeric - fd]=none
        ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
        ZSH_HIGHLIGHT_STYLES[bracket - error]=fg=red,bold
        ZSH_HIGHLIGHT_STYLES[bracket - level - 1]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[bracket - level - 2]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[bracket - level - 3]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[bracket - level - 4]=fg=yellow,bold
        ZSH_HIGHLIGHT_STYLES[bracket - level - 5]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[cursor - matchingbracket]=standout
    fi
else
    PROMPT='${chroot:+($chroot)}%n@%m:%~%# '
fi
unset color_prompt force_color_prompt


# Print a new line before the prompt, but only if it is not the first line
if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
    if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
        _NEW_LINE_BEFORE_PROMPT=1
    else
        print ""
    fi
fi
NEWLINE_BEFORE_PROMPT=yes