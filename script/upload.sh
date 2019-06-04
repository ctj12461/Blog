#!/bin/bash
# upload.sh
cd ..
git clone git@github.com:ctj12461/photos.git ../photos
cp -i source/photos/images/* ../photos/images/
cd ../photos
git add .
git commit -m "Add photo(s) at `date`"
git push origin master
cd ..
rm -rf photos