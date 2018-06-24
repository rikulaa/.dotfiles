#!/bin/bash

# Hammerspoon
# printf "Linking hammerspoon config\n"
if [ -d $HOME/.hammerspoon ] || [ -h $HOME/.hammerspoon ]; then
    rm -rf $HOME/.hammerspoon
fi

ln -sf $DOTFILES_DIR/hammerspoon $HOME/.hammerspoon

