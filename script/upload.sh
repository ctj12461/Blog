#!/bin/bash
# upload.sh
cd ..
git clone git@github.com:ctj12461/photos.git ../photos
cp -i source/album/images/* ../photos/images/
cd ../photos
git add .
git commit -m "Add photo(s) at `date`"
git push -f origin master
cd ..
rm -rf photos