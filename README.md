# autocropLfA
Another short bash script that helps with batch editing image files. Written for Mac. 

## How It Works
This script uses ImageMagick mogrify program to crop a jpg file and overwrite it. Since the masked background can be visually distinguished from the object, this became the way to custom crop each image based on color difference rather than size.

    $ mogrify -bordercolor white -fuzz 3% -trim +repage *.jpg

Various aspects of the code will be highlighted below.

`-bordercolor white:` Sets the border color to be trimmed to white.

`-fuzz 3%:` Adjusts what is considered white based on a percentage.

`-trim:` Crop function.

`+repage:` Resets the image virtual canvas to the actual image.

`*.jpg:` Sets the file format as jpg

`-resize 3000x3000\>:` Resizes image to 3000 pixels on longest size, does not change aspect ratio, does not upscale. 

Additional mogrify arguments to consider: 

`-deskew 10%:` Deskews the image.

`-type TrueColor:` Forces image to be saved as a full color RGB.

`-strip:` Removes xmp file in instances where thumbnail is not adjusting to cropped image.  


Depending on which program is used to convert from tiff to jpg, some produce a file extension of '.jpg' and others '.jpeg'. The for loop below changes all .jpeg extensions to .jpg so they can be ingested into LfA's [Online Archive](oa.letterformarchive.org). 

    for file in ~/Desktop/crop/*
        do
    mv "$file" "${file/.jpeg/.jpg}"
    done

Prompts the user to perform quality control, and asks if they'd like to downscale to 3000 pixels on the longest size of the image. Adapted from [Dennis Williamson](https://stackoverflow.com/questions/19306771/how-can-i-get-the-current-users-username-in-bash)'s SE code snippet. 

    read -p "❗pausing for QC, would you like to resize to 3000px?" -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Nn]$ ]]
    then
        echo 🪚🪵 now on to downsizing, hold please 🛸
        mogrify -resize 3000x3000\> *.jpg 
        echo 🌱 all images resized. 
    fi

## Usage (Mac Only)
1. Make sure you have Homebrew and ImageMagick installed. If not, download [Homebrew](https://brew.sh/) and use to install [ImageMagick](https://imagemagick.org/):

        $ brew install imagemagick

2. This script ships assuming the following folder structure. You are welcome to modify this for your needs within the /autocrop.sh script.

        ├── Desktop
        │   ├── crop
        │   ├── qc        
        │   ├── processed
 
3. Add your images to be processed into the "/Desktop/crop" folder. If you do not have a qc folder, one will be created automatically during processing. 
    1. (optional) If you want to add tiffs that need to be converted to jpgs, run the [makeJpg](https://github.com/elliswmartin/shhelpersLfA/blob/76ee28a9f0195583c54e156cb7b36912f5df4c7e/makeJpg.sh) script. 

            $ sh path/to/autocrop/folder/makeJpgs.sh

4. Open Terminal and run the autocrop script. Images will appear in the "~/Desktop/qc" folder.

        $ sh path/to/autocrop/folder/autocrop.sh

5. Perform quality control when the script pauses and prompts for QC, checking to make sure each images has been adequately cropped. 
    1. Manually crop any images not fully cropped. 

6. After QC is completed:
    * If you would like to resize images, respond "y" to the prompt.
    * If you do not wish to resize or QC will be performed asychronously, respond "n" to the prompt. 
    
7. (optional) To scale images after the autocrop script has been exited and create mids, run the [resize](https://github.com/elliswmartin/shhelpersLfA/blob/76ee28a9f0195583c54e156cb7b36912f5df4c7e/resize.sh) script. 
        
        $ sh path/to/autocrop/folder/resize.sh 

## Background
I developed this script while working at Letterform Archive in San Francisco. It is an extension of [autocrop](https://github.com/elliswmartin/autocrop), developed at Oakland Museum of California in collaboration with two colleagues to batch edit photonegatives. 

## Imaging Setup
Primarily books and flat works ranging from antiquarian books to posters to type specimens imaged on Phase One XF IQ3 100MP camera mounted to a Bear Images Octavo copystand and tethered to Capture One 22 on iMac. 

## Image Properties
Images are in the following state prior to processing with the autocrop script: the background of the image plus the color rendition chart and ruler are masked, on a white background, and flattened. 
