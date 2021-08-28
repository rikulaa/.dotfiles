if [ -e ~/.config/env ] || [ -h ~/.config/env ]; then
    . ~/.config/env

fi
if [ -e ~/.bashrc ] || [ -h ~/.bashrc ]; then
    . ~/.bashrc
fi
