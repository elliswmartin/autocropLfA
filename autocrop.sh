#!/bin/bash -x

# change any ".jpeg" file extensions to ".jpg"
 for file in ~/Desktop/crop/*
 do
  mv "$file" "${file/.jpeg/.jpg}"
done

echo greetings "$USER" π¦ 
echo π¦© extensions renamed to .jpg.

cd ~/Desktop/

# copy files from source to destination, make qc folder if it doesn't exist
mkdir -p "qc" && cp -R ~/Desktop/crop/*.jpg ~/Desktop/qc/

echo π files copied and moved to destination folder. 
echo πͺ¨π¨ now on to cropping! hold please π½ 

cd ~/Desktop/qc

# trim images using ImageMagick
mogrify -bordercolor white -fuzz 3% -trim +repage *.jpg

echo π» cropping complete! 
cd ~/Desktop/

# optional downsize to designated pixel amount: 
read -p "βpausing for QC, would you like to resize to 3000px?" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
    mkdir -p "processed" && cp -R ~/Desktop/qc/*.jpg ~/Desktop/processed/
    cd ~/Desktop/processed
    echo πͺπͺ΅ now on to downsizing, hold please πΈ
    mogrify -resize 3000x3000\> *.jpg 
    echo π± all images resized. 
fi

# copy files from source to destination, make processed folder if it doesn't exist

echo π¦ all edits complete!  

# to run in terminal:
# ~ sh path/to/your/script/>/autocrop.sh
