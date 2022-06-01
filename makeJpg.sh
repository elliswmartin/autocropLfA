#!/bin/bash -x

# make crop folder if does not already exist
cd ~/Desktop/ && mkdir -p "crop" 
cd ~/Desktop/crop/

echo 🪄creating jpgs, hold please 🚀

# create flatten jpgs from tiffs
mogrify -flatten -format jpg *.tif

echo ⭐jpgs created, processing complete. 