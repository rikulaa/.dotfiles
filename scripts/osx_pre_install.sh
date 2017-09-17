#!/bin/bash

# requirements for Homebrew
echo "Installing xcode..."
xcode-select --install | echo "xcode-installed"

echo ""
echo "Installing brew..."
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo ""
brew install git 

echo "Installing zsh.."
brew install zsh