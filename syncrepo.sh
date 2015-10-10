#!/bin/bash

author=$USER
if [ -z "$1" ]; then
	dir="mcertikos"
else
	dir="$1"
fi

reponame="$author.git"
repopath="/c/cs422/SUBMIT/lab/$reponame"

cd $repopath
git --bare fetch origin '+refs/heads/*:refs/heads/*'
cd ~/

echo "****"
echo "Remote repository synchronized successfully."
echo "****"
