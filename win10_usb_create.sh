#!/bin/bash

DEBUG=false

# Get USB disk number
diskutil list
read -p "Enter disk number. Example: 4: " disknum
if [ $DEBUG == true ]; then echo $disknum; fi;
echo

# Get USB Size
read -p "Enter USB Size in GB. Example: 16: " usbsize
if [ $DEBUG == true ]; then echo $usbsize; fi;
echo

# Mount Windows 10 ISO and save mount point as $isomount
read -e -p "Path to Windows 10 ISO: " isopath
isopath="${isopath/"~"/$HOME}"
isovar=$(hdiutil mount ${isopath})
isomount=/Volumes/${isovar##*/}
isosize=$(du -sh $isopath)
isosize=${isosize%%G*}
isosize=$(python3 -c "from math import ceil; print(ceil($isosize))")
isosizep1=$(($isosize+1))
isosizep2=$(($isosize+2))
if [ $DEBUG == true ]; then echo $isomount; fi;
if [ $DEBUG == true ]; then echo $isosize; fi;
echo

# Partition USB
if [ "$isosizep2" -gt "$usbsize" ]; then echo -e "\nUSB not large enough for ISO\n"; exit; fi;
diskutil partitionDisk /dev/disk4 3 GPT ExFAT WIN10 ${isosizep1}GB FAT32 UEFI_NTFS 100M "Free Space" "Free Space" 0
diskutil eraseVolume free free disk${disknum}s1
if [ $DEBUG == true ]; then diskutil list; fi;

# Copy files for UEFI_NTFS to USB
cp -r UEFI_NTFS/* /Volumes/UEFI_NTFS/
echo -e "\nUEFI files copied successfully."
if [ $DEBUG == true ]; then ls /Volumes/UEFI_NTFS/; fi;

# Copy windows 10 files to USB
echo -e "\nCopying Windows 10 files from ISO to USB. This will take 5-10 minutes..."
cp -r ${isomount}/* /Volumes/WIN10/
# cp -rv ${isomount}/* /Volumes/WIN10/
if [ $DEBUG == true ]; then ls /Volumes/WIN10/; fi;

# Complete
diskutil unmount "/Volumes/UEFI_NTFS/"
diskutil unmount "/Volumes/WIN10/"
diskutil unmount "$isomount"
echo -e "\nWindows 10 bootable ExFAT USB creation complete!\n"
echo -e "USB has successfully ejected/unmounted and is safe to remove.\n"