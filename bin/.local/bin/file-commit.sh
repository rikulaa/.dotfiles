#!/bin/sh
cd "$1" || exit

git add --all . && git commit -m "$2"
