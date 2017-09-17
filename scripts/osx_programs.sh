#!/bin/bash

echo "Do you want to install programs specified in Brewfile? (y/n)"
read

if [[ $REPLY = [yY] ]]; then 
        echo "Installing programs..."
        brew tap Homebrew/bundle
        brew bundle
    else 
        echo "Skipping programs" 
    fi