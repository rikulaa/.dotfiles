#!/bin/bash

# Change default shell to zsh
if ! [[ "$(echo $SHELL)" =~ zsh ]]; then
    printf  "Changing default shell to zsh\n"
    sudo sh -c "echo $(which zsh) >> /etc/shells"
    chsh -s $(which zsh)
else
    printf "zsh already default shell\n"
fi
