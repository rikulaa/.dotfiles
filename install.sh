#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# dotfiles directory
dir=~/.dotfiles                    
# old dotfiles backup directory
olddir=~/dotfiles_old             

# list of files/folders to symlink in homedir
# add only files you wish to symlink, this helps to exclude
# files you might not need
files="vimrc vim zshrc bashrc gitconfig tmux.conf aliases"    
binfiles="eslint stamp"
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
        ln -s $dir/$file ~/.$file  
    fi
done

mkdir -p ~/bin
# Link bin 
for binfile in $binfiles; do 
    if [ -a ~/bin/$binfile ]; then
        mv ~/bin/$binfile ~dotfiles_old/bin
    fi
        ln -s $dir/bin/$binfile ~/bin/$binfile
done


#Update submodule (Vundle) so that Vim recognises it
git submodule update --init --recursive
#Install plugins automatically
vim +PluginInstall +qall

# Install oh-my-zsh 
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
