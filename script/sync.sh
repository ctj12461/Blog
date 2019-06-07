#!/bin/bash
# sync.sh

cd ..
git add .
git commit -m "Commit at `date`"
git fetch origin source
git merge source origin/source
git push origin source


a=0
read a