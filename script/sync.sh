#!/bin/bash
# sync.sh

git add .
git commit -m "Commit at `date`"
git fetch origin source
git merge origin/source
git push origin source
cd ..

a=0
read a