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
    nixpkgs.git \
    nixpkgs.ffmpeg

# Install latest an greatest neovim
nix-env -f channel:nixpkgs-unstable -i fzf harper

nix-env -f https://github.com/NixOS/nixpkgs/archive/c9baf8b27b3e1114b13b6406d58e1f6c500eae30.tar.gz -i neovim

# For neovim tree-sitter
nix profile install nixpkgs#lua51Packages.tree-sitter-cli

