#!/bin/sh
# Install's the following programs AND deletes everything else NOT on this list
nix-env -iA \
    nixpkgs.stow \
    nixpkgs.direnv \
    nixpkgs.jq \
    nixpkgs.ripgrep \
    nixpkgs.shellcheck \
    nixpkgs.asciidoctor \
    nixpkgs.tmux \
    nixpkgs.wget \
    nixpkgs.htop \
    nixpkgs.tldr \
    nixpkgs.ffmpeg

# Install latest an greatest neovim
nix-env -f channel:nixpkgs-unstable -i fzf

nix-env -f https://github.com/NixOS/nixpkgs/archive/e6f23dc08d3624daab7094b701aa3954923c6bbb.tar.gz -i neovim
