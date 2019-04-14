# Print columns
jobs | awk '{ print $1 }'

# Regex
awk '/li/ { print $2 }' *file*
