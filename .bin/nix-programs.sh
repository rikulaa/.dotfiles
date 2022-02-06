#!/bin/sh
# Install's the following programs AND deletes everything else NOT on this list
nix-env -i -r \
    stow \
    direnv \
    fzf \
    jq \
    ripgrep \
    shellcheck \
    tmux \
    wget \
    imagemagick \
	htop \
    ffmpeg 

# neovim 6.0.0
nix-env -i neovim-0.6.0 -f https://github.com/NixOS/nixpkgs/archive/89f196fe781c53cb50fef61d3063fa5e8d61b6e5.tar.gz
