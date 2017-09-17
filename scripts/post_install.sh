#!/bin/bash

echo "Changing default shell to zsh.."
sudo chsh -s $(which zsh) $USER
echo ""
echo "If osx, check osx-tweaks"

