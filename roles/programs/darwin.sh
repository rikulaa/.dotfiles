#!/bin/bash

# requirements for Homebrew
printf "Installing xcode command line tools...\n"
xcode-select --install | printf "Command line tools already installed!\n"

# Dont install if brew already exists
if ! $command_exists brew; then
    printf "Installing homebrew...\n"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    printf "Homebrew already installed!\n"
fi

# Install required programs via Homebrew
taps=""
brews="zsh fzf ripgrep tmux neovim python3 node php composer mplayer htop tree"
casks="kitty hammerspoon visual-studio-code firefox keeweb harvest rambox usb-overdrive windscribe slack"

installed_taps=$(brew tap)
for tap in $taps; do
    if echo $installed_taps | grep "$tap" > /dev/null; then
        printf "$tap already tapped! \n"
    else
        printf "Tapping $tap\n"
        brew tap $tarp > /dev/null
    fi
done

installed_brews=$(brew list)
for brew in $brews; do
    if echo $installed_brews | grep "$brew" > /dev/null; then
        printf "$brew already installed \n"
    else
        printf "Installing $brew\n"
        brew install $brew > /dev/null
    fi
done

# Install ctags (they dont have official tap)
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

installed_casks=$(brew cask list)
for cask in $casks; do
    if echo $installed_casks | grep "$cask" > /dev/null; then
        printf "$cask already installed \n"
    else 
        printf "Installing $cask\n"
        brew cask install $cask > /dev/null
    fi
done

# Install neovim dependencies
if ! pip3 show neovim > /dev/null; then
    pip3 install neovim > /dev/null
    printf "Installing python neovim dependencies\n"
else
    printf "Python neovim dependencies already installed\n"
fi
