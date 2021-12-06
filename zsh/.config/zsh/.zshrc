# Enable colors
autoload -U colors && colors

setopt histignorealldups sharehistory
setopt complete_aliases

# Do not beep
setopt nobeep

# Use emacs/vi keybindings even if our EDITOR is set to vi
bindkey -e
# bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.cache/zsh/history

# Use modern completion system
autoload -Uz compinit
compinit

# Better settings for completion menu
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Shift-tab to reverse the menu
bindkey '^[[Z' reverse-menu-complete

# Expand command on !!
bindkey ' ' magic-space

# c-x to open current line in $EDITOR
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Can delete paths by directory
# By default will delete the whole path when pressing ^W
#
# Now, e.g /foo/bar => /foo
default-backward-delete-word () {
  local WORDCHARS="*?_[]~=&;!#$%^(){}<>"
  zle backward-delete-word
}
zle -N default-backward-delete-word
bindkey '^W' default-backward-delete-word

# Configure prompt
precmd() {
    # If there is atleast one job, show the jobs prompt
    JOBS_PROMPT="%F{yellow}%1(j. {%j}.)%f"
    SUDO_PROMPT="%(!.%F{red}# %f.)"

    VENV_PROMPT=""
    if [ -n "${VIRTUAL_ENV+1}" ]; then
        VENV_PROMPT=" (venv)"
    fi

    # Slow as hell
    NODE_PROMPT=""
    # if [ -e "package.json"  ]; then
    #     NODE_PROMPT=" %F{green}(◉: $(node -v))%F"
    # fi

    # Use custom git prompt
    # ZSH has also support for 'vcs_info' but I couldn't get it to display the information the way I wanted
    GIT_PROMPT=''
    is_git_directory() { 
        git status >/dev/null 2>&1 
    }
    if is_git_directory; then
        GIT_BRANCH=$(git branch | sed '/^ /d' | sed 's/\* //')
        GIT_PROMPT=" on %F{red}($GIT_BRANCH)%f"

        is_dirty=$(git status --porcelain | wc -l) 
        if [[ $is_dirty -gt  "0" ]]; then
            GIT_PROMPT=${GIT_PROMPT}"%F{yellow}*%f"
        fi

        git_ahead_count=$(git status -sb | head -1 | grep -o 'ahead\s\d\+' | sed 's/[a-z]\{0,\}[ ]\{0,\}//g')
        git_behind_count=$(git status -sb | head -1 | grep -o 'behind\s\d\+' | sed 's/[a-z]\{0,\}[ ]\{0,\}//g')
        if [  -n "$git_ahead_count" ] || [ -n "$git_behind_count"  ]; then
            GIT_PROMPT="$GIT_PROMPT ["
            if [  -n "$git_ahead_count" ]; then
                GIT_PROMPT=$GIT_PROMPT"%F{green}+$git_ahead_count%f"
            fi
            if [ -n "$git_behind_count"  ]; then
                GIT_PROMPT=$GIT_PROMPT"%F{red}-$git_behind_count%f"
            fi
            GIT_PROMPT="$GIT_PROMPT]"
        fi
    fi

    PS1="$SUDO_PROMPT%F{blue}%c%f$JOBS_PROMPT$GIT_PROMPT$VENV_PROMPT$NODE_PROMPT"$'\n'"%F{blue}λ%F %F{reset_color}"
    # RPS1=""
}

source $XDG_CONFIG_HOME/env
source $XDG_CONFIG_HOME/zsh/plugins/bookmarks
source $XDG_CONFIG_HOME/aliases

# Autosuggestions
# . $shell_dir/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Highlighting
if [ -f "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source $XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Set the terminal theme
. ~/.local/bin/refresh_theme.sh

# Expand aliases when using non-interactive shell
setopt aliases

# Use direnv
eval "$(direnv hook zsh)"
