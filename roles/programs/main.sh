#!/bin/bash

if [[ $OS_NAME =~ "darwin" ]]; then
    $DOTFILES_DIR/roles/programs/darwin.sh
elif [[ $OS_NAME =~ "debian" ]]; then
    $DOTFILES_DIR/roles/programs/debian.sh
fi
