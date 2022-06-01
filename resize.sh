#!/bin/bash -x

cd ~/Desktop/processed
echo 🪚🪵 now on to downsizing, hold please 🛸

# resize to 3000 pixels on the longest side, does not upsize. 
mogrify -resize 3000x3000\> *.jpg 
echo 🌱 all images resized. 