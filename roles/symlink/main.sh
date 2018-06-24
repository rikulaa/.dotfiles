#!/bin/bash

printf "Linking .bashrc, .bash_profile\n"
ln -sf $DOTFILES_DIR/shell/bashrc $HOME/.bashrc
ln -sf $DOTFILES_DIR/shell/bash_profile $HOME/.bash_profile
ln -sf $DOTFILES_DIR/shell/dircolors $HOME/.dircolors

# zshrc
printf "Linking .zshrc\n"
ln -sf $DOTFILES_DIR/shell/zshrc $HOME/.zshrc

# Install oh-my-zsh, if it exists just do git pull
if [ -d $USER_CONFIG_DIR/oh-my-zsh ]; then
    printf "Updating oh-my-zsh...\n"
    cd $USER_CONFIG_DIR/oh-my-zsh 
    git pull $USER_CONFIG_DIR/oh-my-zsh > /dev/null
else 
    printf "Installing oh-my-zsh...\n"
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.config/oh-my-zsh >/dev/null
fi

# tmux
# echo "Linking tmux.conf"
ln -sf $DOTFILES_DIR/tmux/tmux.conf $HOME/.tmux.conf

# vim
printf "Linking vimrc\n"

if [ ! -d $USER_CONFIG_DIR/nvim ]; then
    mkdir -p $USER_CONFIG_DIR/nvim
fi
ln -sf $DOTFILES_DIR/vim/vimrc $HOME/.config/nvim/init.vim
ln -sf $DOTFILES_DIR/vim/vimrc $HOME/.vimrc

printf "Linking ctags\n"
ln -sf $DOTFILES_DIR/vim/ctags $HOME/.ctags

printf "Linking tern-config\n"
ln -sf $DOTFILES_DIR/vim/tern-config $HOME/.tern-config

# git
printf "Linking gitconfig\n"
ln -sf $DOTFILES_DIR/git/gitconfig $HOME/.gitconfig

# bin files
# echo "Checking if $USER_BIN_DIR exists..."
if ! [[ -d $USER_BIN_DIR ]]; then
    echo "$USER_BIN_DIR not found, creating directory"
    mkdir -p $USER_BIN_DIR
fi

# Link files to target bin
# echo "Linking bin"
for file_path in $DOTFILES_DIR/bin/*; do
    filename=$(basename $file_path)

    # Make the actual link
    ln -sf $file_path $USER_BIN_DIR
done

# Additional tasks for osx
if [[ $OS_NAME =~ "darwin" ]]; then
    $DOTFILES_DIR/roles/symlink/darwin.sh
fi

exit 0
