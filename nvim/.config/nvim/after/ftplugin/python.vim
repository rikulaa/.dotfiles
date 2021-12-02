" au BufReadPost,BufWritePost *.py lua require('lint').try_lint('pylint_docker')
