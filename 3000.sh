#!/bin/bash -x

# add to folder where you want to resize to 3000 px on the longest edge.
# then run script in terminal

# resizes files to 3000 px on the longer side
mogrify -resize 3000x3000\> *.jpg 
