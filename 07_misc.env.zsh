

## Prompt ##########################################################
PROMPT_EOL_MARK=""


WORDCHARS=${WORDCHARS//\//} # Don't consider certain characters part of the word
# set a fancy prompt (non-color, unless we know we "want" color)

# Print a new line before the prompt, but only if it is not the first line
if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
    if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
        _NEW_LINE_BEFORE_PROMPT=1
    else
        print ""
    fi
fi
NEWLINE_BEFORE_PROMPT=yes