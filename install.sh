#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="vimrc vim zshrc bashrc gitconfig aliases"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
chmod 772 $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"


#Handle creation of directories if not created
mkdir -p ~/.vim

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    if [ -a $file ]; then
        echo "Moving any existing dotfiles from ~ to $olddir"
        mv ~/.$file ~/dotfiles_old/
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/.$file
    else 
        #if we dont have a file created at $HOME
        touch ~/.$file 
        ls -s $dir/$file ~/.$file  
    fi
done

#Update submodule (Vundle) so that Vim recognises it
git submodule update --init --recursive
#Install plugins automatically
vim +PluginInstall +qall

# Install oh-my-zsh 
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
