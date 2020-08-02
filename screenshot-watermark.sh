#!/bin/bash

# create the watermark
MARK=$(echo oliver25 $(date --rfc-3339=seconds))

# create a unique filename
FILE=~/Pictures/$(date '+%s').png

# take the screenshot
gnome-screenshot -a -f $FILE

# figure out the width of the image for the watermark
width=$(identify -format %w $FILE)

# add the watermark
convert -background '#000A' -fill white -gravity center \
  -size ${width}x40 caption:"$MARK" \
  $FILE +swap -gravity south -composite \
  $FILE

# copy the image to the clipboard
xclip -selection clipboard -t image/png $FILE

# delete the image
rm $FILE
