setlocal formatprg=./vendor/bin/php-cs-fixer\ fix 

let __IncludeActions = {
            \'a': {'title': "add import", 'function': function('PhpInsertUse', []) },
            \'s': {'title': "sort imports", 'function': function('PhpSortUse', []) },
            \}

nnoremap <silent> <leader>L  :call prompter#Show(__IncludeActions)<CR>
