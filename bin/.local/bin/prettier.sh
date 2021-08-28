#!/bin/bash
#place this script in your path, with filename "eslint"

if [[ -f ./node_modules/.bin/prettier  ]]; then
    ./node_modules/.bin/prettier $*
else
    prettier $*
fi
