#!/bin/bash

echo ""
echo "Do you want to bootstrap new system? (y/n)"

echo "Check the scripts -folder if you wish to install only specific parts to your system"
echo ""
read

if [[ $REPLY = [yY] ]]; then 
    echo "Starting installation.."
    echo ""
else 
    echo "Aborting" 
    exit 1
fi


# scripts folder
scripts=./scripts

# get os 
UNAME=$(uname)

# LINUX
if [[ "$UNAME" == 'Linux' ]]; then

    echo ""
    source $scripts/linux_pre_install.sh
    echo ""
    source $scripts/symlink.sh
    echo ""
    source $scripts/linux_programs.sh
    echo ""
    source $scripts/linux_post_install.sh

# OSX
elif [[ "$UNAME" == 'Darwin' ]]; then

    echo ""
    source $scripts/osx_pre_install.sh
    echo ""
    source $scripts/symlink.sh
    echo ""
    source $scripts/osx_programs.sh
    echo ""
    source $scripts/osx_post_install.sh

fi

echo ""
echo ""
echo "Dotfiles installed!"