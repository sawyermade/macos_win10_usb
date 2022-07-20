#!/bin/bash

# Mount Windows 10 ISO and save mount point as $ISOMOUNT
read -e -p "Path to Windows 10 ISO: " ISOPATH
ISOPATH="${ISOPATH/"~"/$HOME}"
ISOVAR=$(hdiutil mount ${ISOPATH})
ISOMOUNT=/Volumes/${ISOVAR##*/}