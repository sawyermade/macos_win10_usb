# Create ExFAT Windows 10 Bootable USB on macOS Monterey Apple Silicon M1
This is how to make a bootable ExFAT USB drive for Windows 10. Took about 6 minutes on Mac Mini M1.

CREDIT FOR UEFI BOOT: [Rufus Team](https://github.com/pbatard/rufus)

## Clone repo and enter directory
Open terminal and run the following commands:
```
git clone https://github.com/sawyermade/macos_win10_usb.git
cd macos_win10_usb
```

## Run bash script
Make sure to pick the correct disk number and USB size in GB
```
chmod +x win10_usb_create.sh
./win10_usb_create.sh
```

### Example input and output from terminal
```
~/GIT/macos_win10_usb (master*) » ./win10_usb_create.sh                                                                    smc@Daniels-Mini
/dev/disk0 (internal):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                         251.0 GB   disk0
   1:             Apple_APFS_ISC                         524.3 MB   disk0s1
   2:                 Apple_APFS Container disk3         245.1 GB   disk0s2
   3:        Apple_APFS_Recovery                         5.4 GB     disk0s3

/dev/disk3 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +245.1 GB   disk3
                                 Physical Store disk0s2
   1:                APFS Volume Macintosh HD            15.2 GB    disk3s1
   2:              APFS Snapshot com.apple.os.update-... 15.2 GB    disk3s1s1
   3:                APFS Volume Preboot                 399.0 MB   disk3s2
   4:                APFS Volume Recovery                836.0 MB   disk3s3
   5:                APFS Volume Data                    143.7 GB   disk3s5
   6:                APFS Volume VM                      1.1 GB     disk3s6

/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *32.1 GB    disk4
   1:       Microsoft Basic Data WIN10                   6.0 GB     disk4s2
   2:       Microsoft Basic Data UEFI_NTFS               99.6 MB    disk4s3
                    (free space)                         25.8 GB    -

/dev/disk6 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *1.0 TB     disk6
   1:                        EFI EFI                     209.7 MB   disk6s1
   2:                 Apple_APFS Container disk7         1000.0 GB  disk6s2

/dev/disk7 (synthesized):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      APFS Container Scheme -                      +1000.0 GB  disk7
                                 Physical Store disk6s2
   1:                APFS Volume BackupMM                212.9 GB   disk7s1
   2:                APFS Volume BackupMBP               397.4 GB   disk7s2

Enter disk number. Example: 4: 4

Enter USB Size in GB. Example: 16: 32

Path to Windows 10 ISO: ~/Downloads/windows_10_pro_x64_vl-2004_REPACK.iso

Started partitioning on disk4
Unmounting disk
Creating the partition map
Waiting for partitions to activate
Formatting disk4s2 as ExFAT with name WIN10
Volume name      : WIN10
Partition offset : 411648 sectors (210763776 bytes)
Volume size      : 11718656 sectors (5999951872 bytes)
Bytes per sector : 512
Bytes per cluster: 32768
FAT offset       : 2048 sectors (1048576 bytes)
# FAT sectors    : 2048
Number of FATs   : 1
Cluster offset   : 4096 sectors (2097152 bytes)
# Clusters       : 183040
Volume Serial #  : 62d96d46
Bitmap start     : 2
Bitmap file size : 22880
Upcase start     : 3
Upcase file size : 5836
Root start       : 4
Mounting disk
Formatting disk4s3 as MS-DOS (FAT32) with name UEFI_NTFS
512 bytes per physical sector
/dev/rdisk4s3: 191534 sectors in 191534 FAT32 clusters (512 bytes/cluster)
bps=512 spc=1 res=32 nft=2 mid=0xf8 spt=32 hds=16 hid=12130304 drv=0x80 bsec=194560 bspf=1497 rdcl=2 infs=1 bkbs=6
Mounting disk
Finished partitioning on disk4
Started erase on disk4s1 (EFI)
Unmounting disk
Finished erase on disk4

UEFI files copied successfully.

Copying Windows 10 files from ISO to USB. This will take 5-10 minutes...

Windows 10 bootable ExFAT USB creation complete!

Volume UEFI_NTFS on disk4s3 unmounted
Volume WIN10 on disk4s2 unmounted
Volume win_10_pro_x64_vl on disk5 unmounted

USB has successfully ejected/unmounted and is safe to remove.
```


# Create NTFS Windows 10 Bootable USB on macOS Monterey Apple Silicon M1
This is how to make a bootable NTFS usb drive for Windows 10

CREDIT FOR UEFI BOOT: [Rufus Team](https://github.com/pbatard/rufus)

## Enable Kernel Extensions so ntfs-3g will work
You want to enable: Allow user management of kernel extensions from identified developers: Allow installation of software that uses legacy kernel extensions.

[Apple Support Link](https://support.apple.com/guide/mac-help/macos-recovery-a-mac-apple-silicon-mchl82829c17/mac)

OR

[Check out this video from Paragon except cmd+R doesnt work on M1, have to hold power button](https://www.youtube.com/watch?v=0EXmDmHm6eg)

## Install brew
[Brew Installation Link](https://brew.sh)

OR

Run in the terminal:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install ntfs-3g & macfuse via brew then restart
Run the following commands in the terminal and reboot to be safe that the extensions are loaded.

Run in terminal:
```
brew tap gromgit/homebrew-fuse
brew install --cask macfuse
brew install ntfs-3g-mac
```
Restart the Mac to be sure it will work correctly.

## Partition USB drive & Format/Mount NTFS
### Clone repo and enter directory
Open terminal and run the following commands:
```
git clone https://github.com/sawyermade/macos_win10_usb.git
cd macos_win10_usb
```

Insert USB drive and run the following commands in the terminal opened above.
### List disk and get /dev disk number
List disk and find your usb drive. It will be an (external, physical) and look for name that is mounted on Desktop
``` 
diskutil list
```

Example: On Desktop name is "Windows"
```
/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *32.1 GB    disk4
   1:               Windows_NTFS Windows                 32.1 GB    disk4s1
```

### Partition USB
Make sure USB drive is at least 16GB or choose different parition sizes (advanced).

For this example, we will be using disk4 which was found from the step above. Replace disk4 with your disk number.
```
diskutil partitionDisk /dev/disk4 3 GPT FAT32 WIN 14GB FAT32 UEFI_NTFS 100M "Free Space" "Free Space" 0
```

Now list disks again to see changes:
```
diskutil list
```

Example: disk4 example found above using 32GB USB
```
/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *32.1 GB    disk4
   1:                        EFI EFI                     209.7 MB   disk4s1
   2:       Microsoft Basic Data WIN                     14.0 GB    disk4s2
   3:       Microsoft Basic Data UEFI_NTFS               99.6 MB    disk4s3
                    (free space)                         17.8 GB    -
```

### Format WIN partition as NTFS instead of FAT32
Run these commands in the terminal opened above. Replace disk4 with disk number found above.
```
diskutil unmount /dev/disk4s2
mkntfs -f -L win10_install /dev/disk4s2
diskutil eraseVolume free free disk4s1
```

Run diskutil list to verify changes:
```
diskutil list
```

Example output with disk being disk4, removes above EFI partition:
```
/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *32.1 GB    disk4
   1:       Microsoft Basic Data win10_install           14.0 GB    disk4s1
   2:       Microsoft Basic Data UEFI_NTFS               99.6 MB    disk4s2
                    (free space)                         17.8 GB    -
```

### Mount NTFS
```
sudo mkdir /Volumes/ntfs
sudo mount -t ntfs -o rw,auto,nobrowse /dev/disk4s2 /Volumes/ntfs
```

## Copy [Rufus](https://github.com/pbatard/rufus) UEFI Files
From within the macos_win10_usb directory
```
cp -r UEFI_NTFS/* /Volumes/UEFI_NTFS
```

## Mount Windows 10 ISO & Copy files
Double click the ISO file and it will automatically mount it. Depending on ISO name, which will be shown on the Desktop.

In my case, name is win_10_pro_x64_vl and mounted at /Volumes/win_10_pro_x64_vl

This will take a while (5-10 min), so using verbose so you can see progress:
```
cp -rv /Volumes/win_10_pro_x64_vl/* /Volumes/ntfs/
```

## Unmount USB disks
```
sudo umount /Volumes/ntfs
diskutil unmount /Volumes/UEFI_NTFS
```

## Load USB on computer
Once ejected/unmounted from mac and placed into your computer, you load the UEFI boot menu for your motherboard/computer and select your USB drive Partition 2 and it should boot. Its a little ghetto, but works and contributions are welcome.