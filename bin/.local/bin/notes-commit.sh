#!/bin/sh
cd ~/Documents/notes || exit

git add --all . && git commit -m "$1"
