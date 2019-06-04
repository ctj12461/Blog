#!/bin/bash
# sync.sh
cd ..
git init ../BlogSource
cp -r script README.md .travis.yml .gitignore scaffolds replace themes source package.json _config.yml ../BlogSource
cd ../BlogSource/
rm -rf source/photos/images
git add .
git commit -m "Commit at `date`"
git remote add origin git@github.com:ctj12461/Blog.git
git checkout -b source
#git pull --allow origin source
git push -f origin source
cd ..
rm -rf BlogSource

