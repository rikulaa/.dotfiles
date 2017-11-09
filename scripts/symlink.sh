#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

# check if user wants to skip this
echo "Symlink dotfiles to your homefolder? (y/n)"
read

if [[ $REPLY = [yY] ]]; then 
        echo "Symlinking dotfiles..."

        # dotfiles directory
        dir=~/.dotfiles                    
        # old dotfiles backup directory
        olddir=~/dotfiles_old             

        # choose files depending on current system
        OS=$(uname)
        if [ $OS == Darwin ]; then
            # osx
            files="vimrc vim emacs zshrc bashrc gitconfig tmux.conf aliases hammerspoon"
        else
            files="vimrc vim emacs zshrc bashrc gitconfig tmux.conf aliases"
        fi

        # create dotfiles_old in homedir
        echo "Creating $olddir for backup of any existing dotfiles in ~"
        mkdir -p $olddir
        chmod 772 $olddir
        echo "...done"

        # change to the dotfiles directory
        echo "Changing to the $dir directory"
        cd $dir
        echo "...done"


        # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
        for file in $files; do
            if [ -a ~/.$file ]; then
                echo "Moving any existing dotfiles from ~ to $olddir"
                mv  ~/.$file ~/dotfiles_old/
            fi

                echo "Creating symlink to $file in home directory."
                ln -Fs $dir/$file ~/.$file
        done

        # # Link bin 
        if [ -a ~/bin ]; then
            echo "Moving old bin from ~ to $olddir"
            mv ~/bin ~/dotfiles_old
        fi
        echo "Creating symlink for bin in home directory"
        ln -s $dir/bin ~/bin

        #Update submodule (Vundle) so that Vim recognises it
        git submodule update --init --recursive
        #Install plugins automatically
        vim +PluginInstall +qall

        # Install oh-my-zsh, move previously installed version to dotfiles_old
        if [ -a ~/.oh-my-zsh ]; then
            mv ~/.oh-my-zsh ~/dotfiles_old/
        fi
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

    else 
        echo "Skipping symlinks" 
    fi
