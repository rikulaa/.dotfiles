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
    nixpkgs.htop \
    nixpkgs.tldr \
    nixpkgs.ffmpeg

# neovim 6.0.0
# nix-env -i neovim-0.6.0 -f https://github.com/NixOS/nixpkgs/archive/89f196fe781c53cb50fef61d3063fa5e8d61b6e5.tar.gz
# neovim 7
# nix-env -i neovim -f https://github.com/NixOS/nixpkgs/archive/ee01de29d2f58d56b1be4ae24c24bd91c5380cea.tar.gz
# neovim 8
# nix-env -i neovim -f https://github.com/NixOS/nixpkgs/archive/refs/tags/22.11.tar.gz
nix-env -i neovim -f https://github.com/NixOS/nixpkgs/archive/a01701dd67e85c483cb623ff15b58a7a1abcab68.tar.gz

# nixpkgs.imagemagick \
