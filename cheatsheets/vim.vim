" Search

" to find 'patt' preceded by 'something'
/\(something\)\zspatt

" Variables

let w:foo = 'bar'    " w: window
let b:state = 'on'   " b: buffer
let t:state = 'off'  " t: tab
echo v:var           " v: vim special

let @/ = ''          " @  register (this clears last search pattern)
echo $PATH           " $  env

let g:ack_options = '-s -H'    " g: global
let s:ack_program = 'ack'      " s: local (to script)
let l:foo = 'bar'              " l: local (to function)


" Operators

a + b             " numbers only!
'hello ' . name   " concat

let var -= 2
let var += 5
let var .= 'string'   " concat



" Strings

let str = "String"
let str = "String with \n newline"

let literal = 'literal, no \ escaping'
let literal = 'that''s enough'  " double '' => '

echo "result = " . re   " concatenation


" String functions

strlen(str)    " length
len(str)       " same
strchars(str)  " character length

split("one two three")       "=> ['one', 'two', 'three']
split("one.two.three", '.')  "=> ['one', 'two', 'three']

join(['a', 'b'], ',')  "=> 'a,b'

tolower('Hello')
toupper('Hello')


" Functions

" prefix with s: for local script-only functions
function! s:Initialize(cmd, args)
  " a: prefix for arguments
  echo "Command: " . a:cmd

  return true
endfunction

" Abortable

function! myfunction() abort
endfunction

" Calling functions

call s:Initialize()
call s:Initialize("hello")

" Consuming return values

echo "Result: " . s:Initialize()


" Namespacing

function! myplugin#hello()


" Var arguments

function! infect(...)
  echo a:0    "=> 2
  echo a:1    "=> jake
  echo a:2    "=> bella

  for s in a:000  " a list
    echon ' ' . s
  endfor
endfunction

infect('jake', 'bella')



" Loops

for s in list
  echo s
  continue  " jump to start of loop
  break     " breaks out of a loop
endfor

while x < 5
endwhile


" Commands with arguments

command! -nargs=? Save call script#foo(<args>)

-nargs=0 	0 arguments, default
-nargs=1 	1 argument, includes spaces
-nargs=? 	0 or 1 argument
-nargs=* 	0+ arguments, space separated
-nargs=+



" Commands calling functions

command! Save call <SID>foo()

function! s:foo()
  ...
endfunction



" Conditionals

let char = getchar()
if char == "\<LeftMouse>"
  " ...
elseif char == "\<RightMouse>"
  " ...
else
  " ...
endif


if 1 | echo "true"  | endif
if 0 | echo "false" | endif

if 1       "=> 1 (true)
if 0       "=> 0 (false)
if "1"     "=> 1 (true)
if "456"   "=> 1 (true)
if "xfz"   "=> 0 (false)

if 3 > 2
if a && b
if (a && b) || (c && d)
if !c

if name ==# 'John'     " case-sensitive
if name ==? 'John'     " case-insensitive
if name == 'John'      " depends on :set ignorecase

" identify operators
a is b
a isnot b

" REgex matches
"hello" =~ '/x/'
"hello" !~ '/x/'

" Boolean logic

if g:use_dispatch && s:has_dispatch
  ···
endif

" Single line

if empty(a:path) | return [] | endif
a ? b : c


" Lists

let mylist = [1, two, 3, "four"]

let first = mylist[0]
let last  = mylist[-1]

" Suppresses errors
let second = get(mylist, 1)
let second = get(mylist, 1, "NONE")

len(mylist)
empty(mylist)

sort(list)
let sortedlist = sort(copy(list))

split('hello there world', ' ')

let shortlist = mylist[2:-1]
let shortlist = mylist[2:]     " same

let shortlist = mylist[2:2]    " one item

let longlist = mylist + [5, 6]
let mylist += [7, 8]

call map(files, "bufname(v:val)")  " use v:val for value
call filter(files, 'v:val != ""')

let alist = [1, 2, 3]
let alist = add(alist, 4)

" Dictionaries

let colors = {
  \ "apple": "red",
  \ "banana": "yellow"
}

echo colors["a"]
echo get(colors, "apple")   " suppress error

remove(colors, "apple")

" :help E715
if has_key(dict, 'foo')
if empty(dict)
keys(dict)
len(dict)

max(dict)
min(dict)

count(dict, 'x')
string(dict)

map(dict, '<>> " . v:val')

remove(colors, "apple")

" :help E715
if has_key(dict, 'foo')
if empty(dict)
keys(dict)
len(dict)

max(dict)
min(dict)

count(dict, 'x')
string(dict)

map(dict, '<>> " . v:val')


" Extending with more
let extend(s:fruits, { ... })


" Casting

str2float("2.3")
str2nr("3")
float2nr("3.14")


" Getting filenames

echo expand("%")      " path/file.txt
echo expand("%:t")    " file.txt
echo expand("%:p:h")  " /home/you/path/file.txt
echo expand("%:r")    " path/file
echo expand("%:e")    " txt


