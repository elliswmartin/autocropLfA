#!/bin/bash -x

# make crop folder if it does not already exist
cd ~/Desktop/ && mkdir -p "crop" 
cd ~/Desktop/makeJpg/

echo 🪄creating jpgs, hold please 🚀

# create flatten jpgs from tiffs
mogrify -flatten -format jpg *.tif

# move jpgs to destination folder
mv *.jpg ~/Desktop/crop

echo ⭐jpgs created and moved to crop folder. 