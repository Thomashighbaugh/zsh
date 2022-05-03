################################################################################
## Colors ######################################################################
################################################################################


#source $HOME/.zsh/hyperzsh.zsh

setopt prompt_subst
autoload colors
colors

autoload -Uz vcs_info
host_color=cyan
user_color=green
root_color=red
directory_color=magenta
error_color=red
jobs_color=green
vcs_color=blue

host_prompt="%{$fg_bold[$host_color]%}%M%{$reset_color%}"

jobs_prompt1="%{$fg_bold[$jobs_color]%}(%{$reset_color%}"
jobs_prompt2="%{$fg[$jobs_color]%}%j%{$reset_color%}"
jobs_prompt3="%{$fg_bold[$jobs_color]%})%{$reset_color%}"

jobs_total="%(1j.${jobs_prompt1}${jobs_prompt2}${jobs_prompt3} .)"

error_prompt1="%{$fg_bold[$error_color]%}<%{$reset_color%}"
error_prompt2="%{$fg[$error_color]%}%?%{$reset_color%}"
error_prompt3="%{$fg_bold[$error_color]%}>%{$reset_color%}"

error_total="%(?..${error_prompt1}${error_prompt2}${error_prompt3} )"

directory_prompt="%{$fg[$directory_color]%}%~%{$reset_color%} "

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stangedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
fmt_branch="%b%{$fg_bold[yellow]%}%{$reset_color%}%u%{$fg_bold[green]%}%c%{$reset_color%}" # e.g. master¹²
fmt_action="(%{$fg[red]%}%a%{$reset_color%})"   # e.g. (rebase-i)
fmt_pre="%{$fg_bold[$vcs_color]%}«%{$reset_color%}%{$fg[$vcs_color]%}"
fmt_post="%{$fg_bold[$vcs_color]%}»%{$reset_color%}"

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr '¹'  # display ¹ if there are unstaged changes
zstyle ':vcs_info:*:prompt:*' stagedstr '²'    # display ² if there are staged changes
zstyle ':vcs_info:*:prompt:*' actionformats "${fmt_pre}${fmt_branch}${fmt_action}${fmt_post} "
zstyle ':vcs_info:*:prompt:*' formats       "${fmt_pre}${fmt_branch}${fmt_post} "
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""
zstyle ':vcs_info:*:prompt:*' enable git

function precmd {
   vcs_info 'prompt'
}

vcs='$vcs_info_msg_0_'
RPROMPT="%{$fg_bold[white]%}ॐ \$(date)%{$reset_color%}"

function lprompt {
  local vimode='${PR_VIMODE}'
  local vicol='${PR_VICOLOR}'

  PROMPT="${host_prompt} ${jobs_total}${directory_prompt}${vcs}${error_total}%{${vicol}%}ॐ%{$reset_color%} "
}

lprompt

PR_VIMODE='ॐ'
PR_VICOLOR="$fg_bold[green]"
function zle-line-init zle-keymap-select {
  PR_VIMODE="${${KEYMAP/vicmd/¢}/(main|viins)/$}"
  PR_VICOLOR="${${KEYMAP/vicmd/$fg_bold[red]}/(main|viins)/$fg_bold[green]}"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

