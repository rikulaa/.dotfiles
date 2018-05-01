# SHELL #

# Variables 
NAME="John"
echo $NAME
echo "$NAME"
echo "${NAME}!"

# String
NAME="John"
echo "Hi $NAME"  #=> Hi John
echo 'Hi $NAME'  #=> Hi $NAME

# Shell execution
echo "I'm in $(pwd)"
echo "I'm in `pwd`"

# print columns
printf '%-15s  %-30s' ' --programs' 'Install additional programs' 

git commit && git push 
git commit || echo "Commit failed"


# Conditionals

# check if cmd exists
# stdout to null, stderr to stdout?
exists()
{
  command -v "$1" >/dev/null 2>&1
}

[ -z STRING ] 	Empty string
[ -n STRING ] 	Not empty string
[ NUM -eq NUM ] 	Equal
[ NUM -ne NUM ] 	Not equal
[ NUM -lt NUM ] 	Less than
[ NUM -le NUM ] 	Less than or equal
[ NUM -gt NUM ] 	Greater than
[ NUM -ge NUM ] 	Greater than or equal
[[ STRING =~ STRING ]] 	Regexp
(( NUM < NUM )) 	Numeric conditions
[ -o noclobber ] 	If OPTIONNAME is enabled
[ ! EXPR ] 	Not
[ X ] && [ Y ] 	And
[ X ] || [ Y ] 	Or

# File conditions

[ -e FILE ] 	Exists
[ -r FILE ] 	Readable
[ -h FILE ] 	Symlink
[ -d FILE ] 	Directory
[ -w FILE ] 	Writable
[ -s FILE ] 	Size is > 0 bytes
[ -f FILE ] 	File
[ -x FILE ] 	Executable
[ FILE1 -nt FILE2 ] 	1 is more recent than 2
[ FILE1 -ot FILE2 ] 	2 is more recent than 1
[ FILE1 -ef FILE2 ] 	Same files


# String
if [ -z "$string" ]; then
  echo "String is empty"
elif [ -n "$string" ]; then
  echo "String is not empty"
fi

# Combinations
if [ X ] && [ Y ]; then
  ...
fi

# Regex
if [[ "A" =~ "." ]]

if (( $a < $b ))

if [ -e "file.txt" ]; then
  echo "file exists"
fi

# Switch cas
case "$1" in
  start | up)
    vagrant up
    ;;

  *)
    echo "Usage: $0 {start|stop|ssh}"
    ;;
esac



# Arrays

# Defining arrays

Fruits=('Apple' 'Banana' 'Orange')

Fruits[0]="Apple"
Fruits[1]="Banana"
Fruits[2]="Orange"

# Working with arrays

echo ${Fruits[0]}           # Element #0
echo ${Fruits[@]}           # All elements, space-separated
echo ${#Fruits[@]}          # Number of elements
echo ${#Fruits}             # String length of the 1st element
echo ${#Fruits[3]}          # String length of the Nth element
echo ${Fruits[@]:3:2}       # Range (from position 3, length 2)


# Operations

Fruits=("${Fruits[@]}" "Watermelon")    # Push
Fruits=( ${Fruits[@]/Ap*/} )            # Remove by regex match
unset Fruits[2]                         # Remove one item
Fruits=("${Fruits[@]}")                 # Duplicate
Fruits=("${Fruits[@]}" "${Veggies[@]}") # Concatenate
lines=(`cat "logfile"`)                 # Read from file


# Iteration

for i in "${arrayName[@]}"; do
  echo $i
done


## Misc

# Redirection

python hello.py > output.txt   # stdout to (file)
python hello.py >> output.txt  # stdout to (file), append
python hello.py 2> error.log   # stderr to (file)
python hello.py 2>&1           # stderr to stdout
python hello.py 2>/dev/null    # stderr to (null)

python hello.py < foo.txt

