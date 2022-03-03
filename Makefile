.DEFAULT: help
.PHONY: help brew-bundle nix-programs link-configs unlink-configs install-vim-plugins change-login-shell gnome-settings osx-defaults

UNAME = $(shell uname)

help:           ## Show this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <target>\033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

install: | $(UNAME)-install ## Setup new machine

Darwin-install: nix-programs brew-bundle link-configs install-vim-plugins change-login-shell osx-defaults
Linux-install: nix-programs link-configs install-vim-plugins change-login-shell gnome-settings

brew-bundle: ## Install brew programs
	brew bundle

nix-programs: ## Install nix programs
	./.bin/nix-programs.sh

apt-programs: apt-docker
apt-docker: ## Install docker via apt
	sudo apt install docker.io docker-compose -y
	$(info Add current user to docker group, RE-LOGIN for changes to take effect)
	sudo usermod -aG docker ${USER}

# OSX has a bit more configurations
ifeq ($(UNAME),Darwin)
CONFIG_DIRS = bin nvim zsh git tmux hammerspoon karabiner
else
CONFIG_DIRS = bin nvim zsh git tmux
endif

link-configs: ## Link configuration files
	$(info Linking configuration ($(CONFIG_DIRS)) files for $(UNAME))
	stow $(CONFIG_DIRS)

unlink-configs: ## Unlink configuration files
	$(info Un-linking configuration ($(CONFIG_DIRS)) files for $(UNAME))
	stow -D $(CONFIG_DIRS)

install-vim-plugins: ## Install vim-plugins
	$(info Installing vim-plugins)
	nvim +PlugInstall +qall

change-login-shell: ## Change login shell to zsh
	$(info Changing default shell to zsh)
	sudo sh -c "echo $(shell which zsh) >> /etc/shells"
	chsh -s $(shell which zsh)

osx-defaults: ## Write osx defaults
	defaults write -g InitialKeyRepeat -int 25
	defaults write -g KeyRepeat -int 2
	defaults write com.apple.dock orientation -string right # Dock to the right
	defaults write com.apple.dock magnification -bool false
	defaults write com.apple.dock autohide -int 1
	defaults write com.apple.dock autohide-delay -int 0

gnome-settings: ## Better defaults to gnome-shell
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'RIGHT'
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false

flatpak: # Install flatpack
	sudo apt install flatpak -y
	sudo apt install gnome-software-plugin-flatpak -y
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	

