# Dotfiles
These are my personal configs for bash, zsh, tmux, git, hammerspoon and vim

## Installation
Dependencies: git, curl, make*

1. Install pre-requisites with `./configure`
2. Start new shell (and install e.g `make`)
3. Run `make install`

### Terminal

#### Iterm2

Change font to `Iosevak medium extended`
Download nord colorscheme from `https://raw.githubusercontent.com/arcticicestudio/nord-iterm2/develop/src/xml/Nord.itermcolors` and import it

Add [Iosevka](https://github.com/be5invis/Iosevka) as font

## VS-Code
Download syncing, setup with gist and download settings

## Nix

Some times the newer nix version might contain programs which won't compile.
To search for older version look here: https://lazamar.co.uk/nix-versions/

NOTE: in linux, you might need to do the following: https://github.com/NixOS/nixpkgs/issues/38991#issuecomment-496332104
```
export LOCALE_ARCHIVE_2_11="$(nix-build --no-out-link "<nixpkgs>" -A glibcLocales)/lib/locale/locale-archive"
export LOCALE_ARCHIVE_2_27="$(nix-build --no-out-link "<nixpkgs>" -A glibcLocales)/lib/locale/locale-archive"
export LOCALE_ARCHIVE="/usr/bin/locale"
```

## Keymappings

Remaps and shortcuts are done with
- hammerspoon
- karabiner
- osx settings (switching between workspaces)
