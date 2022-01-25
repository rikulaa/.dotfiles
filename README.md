# Dotfiles
These are my personal configs for bash, zsh, tmux, git, hammerspoon and vim

## Installation
Dependencies: git, brew, stow, nix

0. Install nix and homebrew

```sh
sh <(curl -L https://nixos.org/nix/install)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle
```

1. Run stow to symlink wanted configs. E.g `stow nvim git shell hammerspoon bin ...`.
```sh
stow nvim git shell hammerspoon bin git tmux zsh karabiner
```

2. Run setup script (NOTE: install language runtimes with ASDF)

See 'setup'-folder for installation scripts. 
On osx setup-brew must be run first.
Running the installation scripts nukes your previous configuration.

Add [Iosevka](https://github.com/be5invis/Iosevka) as font

## VS-Code
Download syncing, setup with gist and download settings

## Nix

Some times the newer nix version might contain programs which won't compile.
To search for older version look here: https://lazamar.co.uk/nix-versions/
