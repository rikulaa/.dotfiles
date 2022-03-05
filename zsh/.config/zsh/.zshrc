# Enable colors
autoload -U colors && colors

setopt complete_aliases
# Expand aliases when using non-interactive shell
setopt aliases

# Do not beep
setopt nobeep

# Use emacs/vi keybindings even if our EDITOR is set to vi
bindkey -e
# bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.cache/zsh/history
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

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

# Version control info prompt
setopt PROMPT_SUBST
autoload -Uz vcs_info 
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' formats       \
    ' on %F{red}(%b)%f%F{yellow}%u%c%f '
zstyle ':vcs_info:*' actionformats       \
    ' on %F{red}(%b|%a)%f%F{yellow}%u%c%f '
zstyle ':vcs_info:*' stagedstr       \
    '%F{green}*%f'
zstyle ':vcs_info:*' unstagedstr       \
    '%F{yellow}*%f'


# Configure prompt
precmd() {
    # Load vcs_info
    vcs_info
    # If there is atleast one job, show the jobs prompt
    JOBS_PROMPT="%F{yellow}%1(j. {%j}.)%f"
    SUDO_PROMPT="%(!.%F{red}# %f.)"

    VENV_PROMPT=""
    if [ -n "${VIRTUAL_ENV+1}" ]; then VENV_PROMPT=" (venv)" fi # Slow as hell

    PS1="$SUDO_PROMPT%F{blue}%c%f$JOBS_PROMPT${vcs_info_msg_0_}$VENV_PROMPT$NODE_PROMPT"$'\n'"%F{blue}λ%F %F{reset_color}"
    # RPS1=""
}

reload() {
    source $ZDOTDIR/.zshrc
}
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
elif [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh" 
fi
# End Nix

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


# Use direnv
eval "$(direnv hook zsh)"
