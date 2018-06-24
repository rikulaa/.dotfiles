#!/bin/bash

# Install programs
programs="zsh tmux neovim mplayer kitty php curl python3 python3-pip firefox"

sudo apt update

for program in $programs; do
     if ! exists $program; then
         printf "Installing $program\n"
         sudo apt install $program >/dev/null
     else
         printf "$program already installed\n"
     fi
done

# vscode
if ! exists code; then
    printf "Installing vscode \n"
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

    sudo apt-get update
    sudo apt-get install code # or code-insiders
else 
    printf "vscode already installed\n"
fi


# fzf
if [[ -d $dotfiles_dir/tools/fzf ]]; then
    printf "FZF repository already exists, updating\n"
    # Delete previous binaries
    cd $dotfiles_dir/tools/fzf/
    rm $dotfiles_dir/tools/fzf/bin/fzf
    git pull
else
    printf "Cloning FZF repository...\n"
    git clone --depth 1 https://github.com/junegunn/fzf.git $dotfiles_dir/tools/fzf
fi

$dotfiles_dir/tools/fzf/install --bin

#  Create ~/.local/bin dir if it doesn't exist
if [ ! -d $HOME/.local/bin ]; then
    mkdir -p $HOME/.local/bin
fi

cp -f $dotfiles_dir/tools/fzf/bin/fzf $HOME/.local/bin/fzf


# ripgrep

# Add last modified date to the beginning of the file
RIPGREP_LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/BurntSushi/ripgrep/releases/latest)
RIPGREP_LATEST_VERSION=$(echo $RIPGREP_LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')

ripgrep_dir=$HOME/.dotfiles/tools/ripgrep-$RIPGREP_LATEST_VERSION

old_versions=$HOME/.dotfiles/tools/ripgrep*

# Remove old versions
for version in $old_versions; do
    printf $(basename $version)
    if [ "$(basename $version)" != "ripgrep-$RIPGREP_LATEST_VERSION" ]; then
        rm -rf $version
    fi
done

if [ -e $ripgrep_dir ] && [ -e $HOME/.local/bin/rg ]; then
    printf "Ripgrep already up to date\n"
    
else
    rm -rf $old_versions
    mkdir $ripgrep_dir
    cd $ripgrep_dir

    TARGET_URL="https://github.com/BurntSushi/ripgrep/releases/download/$RIPGREP_LATEST_VERSION/ripgrep-$RIPGREP_LATEST_VERSION-x86_64-unknown-linux-musl.tar.gz"
    TAR_PACKAGE=ripgrep-$RIPGREP_LATEST_VERSION-x86_64-unknown-linux-musl.tar.gz
    EXTRACTED_FOLDER=ripgrep-$RIPGREP_LATEST_VERSION-x86_64-unknown-linux-musl

    curl -OL $TARGET_URL
    # tar -xvf $TAR_PACKAGE
    # Extracting tar package, to -C 'direcotry' and stripping additional root folders
    mkdir -p $ripgrep_dir/rg && tar -xvf $TAR_PACKAGE -C rg --strip-components=1

    if [ ! -d $HOME/.local/bin ]; then
        mkdir -p $HOME/.local/bin
    fi

    # Copy new binary
    cp -f $ripgrep_dir/rg/rg $HOME/.local/bin/rg

    # Remove tar file
    rm $TAR_PACKAGE
fi


#####################
# Development dependencies

# nodejs
if ! exists node; then
    curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
    sudo apt-get install -y nodejs
else 
    printf "node already installed \n"
fi

# composer
if ! exists composer; then
    local EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    local ACTUAL_SIGNATURE="$(php -r "echo hash_file('SHA384', 'composer-setup.php');")"

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
    then
        >&2 echo 'ERROR: Invalid installer signature'
    else
        php composer-setup.php --quiet --install-dir=$HOME/.local/bin --filename=composer
    fi

    rm composer-setup.php

else 
    printf "composer already installed \n"
fi

if ! pip3 list | grep neovim; then
    printf "Installing python neovim dependencies\n"
    pip3 install neovim
else
    printf "neovim python depencies already installed!\n"
fi
