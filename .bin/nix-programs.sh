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
nix-env -f channel:nixpkgs-unstable -i neovim fzf
