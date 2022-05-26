#!/bin/bash -x

# change any ".jpeg" file extensions to ".jpg"
 for file in ~/Desktop/crop/*
 do
  mv "$file" "${file/.jpeg/.jpg}"
done

echo greetings "$USER" 🦋 
echo 🦩 extensions renamed to .jpg.

cd ~/Desktop/

# copy files from source to destination, make qc folder if it doesn't exist
mkdir -p "qc" && cp -R ~/Desktop/crop/*.jpg ~/Desktop/qc/

echo 📁 files copied and moved to destination folder. 
echo 🪨🔨 now on to cropping! hold please 👽 

cd ~/Desktop/qc

# trim images using ImageMagick
mogrify -bordercolor white -fuzz 3% -trim +repage *.jpg

echo 🌻 cropping complete! 
cd ~/Desktop/

# optional downsize to designated pixel amount: 
read -p "❗pausing for QC, would you like to resize to 3000px?" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
    mkdir -p "processed" && cp -R ~/Desktop/qc/*.jpg ~/Desktop/processed/
    cd ~/Desktop/processed
    echo 🪚🪵 now on to downsizing, hold please 🛸
    mogrify -resize 3000x3000\> *.jpg 
    echo 🌱 all images resized. 
fi

# copy files from source to destination, make processed folder if it doesn't exist

echo 🍦 all edits complete!  

# to run in terminal:
# ~ sh path/to/your/script/>/autocrop.sh
