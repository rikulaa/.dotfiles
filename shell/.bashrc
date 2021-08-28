# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# We use preexec and precmd hook functions for Bash
# If you have anything that's using the Debug Trap or PROMPT_COMMAND 
# change it to use preexec or precmd
# See also https://github.com/rcaloras/bash-preexec

# Lot of settings taken from
# https://github.com/mrzool/bash-sensible/blob/master/sensible.bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


## GENERAL OPTIONS ##

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space
# Kill whole line with Control-g
bind '"\C-g": kill-whole-line'

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Colors
color_reset='\[\033[0m\]'
sky_blue='\[\033[34m\]'
light_sky_blue='\[\033[1;34m\]'

blue='\[\033[36m\]'
light_blue='\[\033[1;36m\]'

red='\[\033[31m\]'
light_red='\[\033[1;31m\]'

green='\[\033[32m\]'
light_green='\[\033[1;32m\]'

purple='\[\033[35m\]'
light_purple='\[\033[1;35m\]'

white='\[\033[0m\]'

function prompt_command {
    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    force_color_prompt=yes

    # Background processes
    BACKGROUND_JOBS_PROMPT=$( [ -z "$(jobs | tail -1)" ] && echo '' || echo " $green[\j]$color_reset")

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

    # Add git to prompt
    is_git() { 
        git status >/dev/null 2>&1 
    }

    GIT_PROMPT=''
    if is_git; then

        git_status=$(git status -sb)

        git_dirty_files=$(echo $git_status | grep '[AMD??]' -c) 
        git_dirty=''
        if [[ $git_dirty_files > 0 ]]; then
            git_dirty='\[\033[33m\]*'
        fi

        git_branch=" ($(git branch | sed -n 's/[*][a-zA-Z/]*//p' | cut -b 2- || ''))"

        git_ahead_amount=$(echo $git_status | grep 'ahead.[0-9]' -o | cut -b 7- )
        git_ahead=''
        if [[ $git_ahead_amount > 0 ]]; then
            # green
            git_ahead=" $green+$git_ahead_amount"
        fi

        git_behind=''
        git_behind_amount=$(echo $git_status | grep 'behind.[0-9]' -o | cut -b 8-)
        if [[ $git_behind_amount > 0 ]]; then
            # red 
            git_behind="$red-$git_behind_amount"
            
        fi

        GIT_PROMPT="$red$git_branch$git_dirty$git_ahead$git_behind$color_reset"
    fi

    if [ "$color_prompt" = yes ]; then
        PS1="$light_sky_blue\W$color_reset$GIT_PROMPT$BACKGROUND_JOBS_PROMPT "
    else
        PS1='\u@\h:\w'
    fi
}
PROMPT_COMMAND=prompt_command

unset color_prompt force_color_prompt

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
shell_dir=$HOME/.dotfiles/shell

# . $shell_dir/env
. $XDG_CONFIG_HOME/aliases
. $shell_dir/plugins/bookmarks

# Source git completion
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    . /usr/local/etc/bash_completion.d/git-completion.bash
fi

#disabling ctr-s behavior in terminal
stty -ixon

# Set the terminal theme
. ~/.local/bin/refresh_theme.sh
