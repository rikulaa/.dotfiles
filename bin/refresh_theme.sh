#!/bin/bash

# Dark/light theme for OSX
if [[ "$(uname -s)" == "Darwin" ]]; then
    sith() {
        if [[ "$1" ]]; then
            val=$1
        else
            val=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
            if [[ -z  $val ]]; then
                val="Light"
            fi
        fi
        echo -ne "\033]50;SetProfile=$val\a"
        export ITERM_PROFILE="$val"
    }
sith $1
fi
