if exists("current_compiler")
  finish
endif
let current_compiler = "jest"

CompilerSet makeprg=CI=true\ yarn\ test
CompilerSet errorformat=%.%#\ at\ %f:%l:%c,%.%#\ at\ %.%#(%f:%l:%c)
