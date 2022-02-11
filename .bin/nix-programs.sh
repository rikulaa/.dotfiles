#!/bin/sh
# Install's the following programs AND deletes everything else NOT on this list
nix-env -iA \
    nixpkgs.stow \
    nixpkgs.direnv \
    nixpkgs.fzf \
    nixpkgs.jq \
    nixpkgs.ripgrep \
    nixpkgs.shellcheck \
    nixpkgs.asciidoctor \
    nixpkgs.tmux \
    nixpkgs.wget \
    nixpkgs.imagemagick \
	nixpkgs.htop \
    nixpkgs.ffmpeg 

# neovim 6.0.0
nix-env -i neovim-0.6.0 -f https://github.com/NixOS/nixpkgs/archive/89f196fe781c53cb50fef61d3063fa5e8d61b6e5.tar.gz
