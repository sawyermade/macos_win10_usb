#!/bin/bash

DEBUG=true

# Get USB disk number
diskutil list
read -p "Enter disk number. Example: 4: " DISKNUM
if [ $DEBUG == true ]; then echo $DISKNUM; fi;

# Mount Windows 10 ISO and save mount point as $ISOMOUNT
read -e -p "Path to Windows 10 ISO: " ISOPATH
ISOPATH="${ISOPATH/"~"/$HOME}"
ISOVAR=$(hdiutil mount ${ISOPATH})
ISOMOUNT=/Volumes/${ISOVAR##*/}
if [ $DEBUG == true ]; then echo $ISOMOUNT; fi;