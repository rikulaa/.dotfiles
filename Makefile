UNAME := $(shell uname)

.MAIN: help
.PHONY: help initialize brew-bundle nix-programs link-configs unlink-configs install-vim-plugins change-login-shell

help:           ## Show this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

initialize: ## Install pre-requisites for new machines
	./.bin/initialize.sh

# OSX has different steps
ifeq ($(UNAME),Darwin)
INSTALL_STEPS := nix-programs brew-bundle link-configs install-vim-plugins change-login-shell
else
INSTALL_STEPS := nix-programs link-configs install-vim-plugins change-login-shell
endif

install: | $(INSTALL_STEPS) ## Setup new machine

brew-bundle:
	brew bundle

nix-programs:
	./.bin/nix-programs.sh

# OSX has a bit more configurations
ifeq ($(UNAME),Darwin)
CONFIG_DIRS := bin nvim zsh git tmux hammerspoon karabiner
else
CONFIG_DIRS := bin nvim zsh git tmux
endif

link-configs:
	$(info Linking configuration ($(CONFIG_DIRS)) files for $(UNAME))
	stow $(CONFIG_DIRS)

unlink-configs:
	$(info Un-linking configuration ($(CONFIG_DIRS)) files for $(UNAME))
	stow -D $(CONFIG_DIRS)

install-vim-plugins:
	$(info Installing vim-plugins)
	nvim +PlugInstall +qall

change-login-shell:
	$(info Changing default shell to zsh)
	sudo sh -c "echo $(shell which zsh) >> /etc/shells"
	chsh -s $(shell which zsh)


