#!/bin/sh

PLATFORM=$(uname)
NIX_SCRIPT_NAME="./tmp-install-nix-script.sh"

printf "Platform: %s\n\n" "$PLATFORM"

# Download nix install script and give permissions to run it
download_nix_install_script() {
    printf "Downloading nix install script...\n"
    curl -L https://nixos.org/nix/install > $NIX_SCRIPT_NAME && chmod +x $NIX_SCRIPT_NAME
}

(printf "Checking pre-requisites...\n" && which curl && printf "\n") || (printf "'curl' is not found, exiting..." && exit)

printf "===========================\n\n"

if [ "$PLATFORM" = "Darwin" ]; then
    # Setup homebrew
    printf "Installing Homebrew...\n"
    (printf "Checking if Homebrew installed already installed...: " && which brew && echo "Homebrew already installed!") || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    printf "\n"

    # Setup nix, if already installed bail out
    printf "Checking if nix already installed...: " && which nix-env && echo "Nix already installed!" && exit

    # Download and run
    download_nix_install_script && $NIX_SCRIPT_NAME
    rm $NIX_SCRIPT_NAME
else
    # Setup nix, if already installed bail out
    printf "Checking if nix already installed...: " && which nix-env && echo "Nix already installed!" && exit

    # Download and run
    download_nix_install_script && $NIX_SCRIPT_NAME --daemon
fi


