help:
	@echo "dotfiles Makefile"
	@echo "#################"
	@echo "Choose between osx or linux system"

osx:
	@echo "Setting up osx..."
	bash ./scripts/pre_install_osx.sh
	bash ./install.sh
	bash ./scripts/setup_osx.sh
	bash ./scripts/post_install.sh

linux:
	@echo "Setting up linux..."
	bash ./scripts/pre_install_linux.sh
	bash ./install.sh
	bash ./scripts/post_install.sh
	
.PHONY: test
test: test2 test3

test2:
	echo "im test 2"

test3:
	echo "im test 3"