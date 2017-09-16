help:
	@echo "dotfiles Makefile"
	@echo "#################"

install_symlinks:
	bash ./install.sh
	

install_osx:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

install_linux:
	sudo apt install git
	sudo apt install zsh
	chsh -s "$(which zsh)"

