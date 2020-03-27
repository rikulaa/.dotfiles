# Add second remote, pull from it

git remote add something git://host.example.com/path/to/repo.git
git checkout master
git pull something master

# Pull without adding remote
git pull git://host.example.com/path/to/repo.git
