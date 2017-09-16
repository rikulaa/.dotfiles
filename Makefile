help:
	@echo "dotfiles Makefile"
	@echo "#################"

install_symlinks:
	bash ./install.sh
	

install_osx:
	xcode-select --install
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew tap Homebrew/bundle
	brew bundle
	@echo "Remember to check osx-tweaks"

install_linux:
	sudo apt install git
	sudo apt install zsh
	chsh -s $(shell which zsh)

