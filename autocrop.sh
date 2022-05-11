#!/bin/bash -x

# change any ".jpeg" file extensions to ".jpg"
 for file in ~/Desktop/crop/*
 do
  mv "$file" "${file/.jpeg/.jpg}"
done

echo greetings "$USER" 🦋 
echo 🦩 extensions renamed to .jpg.

cd ~/Desktop/

# copy files from source to destination, make processed folder if it doesn't exist
mkdir -p "processed" && cp -R ~/Desktop/crop/*.jpg ~/Desktop/processed/

echo 📁 files copied and moved to destination folder. 
echo 🪨🔨 now on to cropping! hold please 👽 

cd ~/Desktop/processed

# trim and deskew images using ImageMagick
mogrify -background white -fuzz 3% -trim +repage -type TrueColor *.jpg

echo 🌻 cropping complete! 

# optional downsize to designated pixel amount: 
read -p "❗pausing for QC, would you like to resize to 3000px?" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
    echo 🪚🪵 now on to downsizing, hold please 🛸
    mogrify -resize 3000x3000\> *.jpg 
    echo 🌱 all images resized. 
fi

echo 🍦 all edits complete!  

# to run in terminal:
# ~ sh path/to/your/script/>/autocrop.sh
