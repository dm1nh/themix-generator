#!/bin/sh
sed -i \
         -e 's/#181922/rgb(0%,0%,0%)/g' \
         -e 's/#b3bde4/rgb(100%,100%,100%)/g' \
    -e 's/#15161e/rgb(50%,0%,0%)/g' \
     -e 's/#b3d57d/rgb(0%,50%,0%)/g' \
     -e 's/#33343d/rgb(50%,0%,50%)/g' \
     -e 's/#b3bde4/rgb(0%,0%,50%)/g' \
	"$@"
