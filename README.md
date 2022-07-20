# Create Windows 10 Bootable USB on macOS Apple Silicon M1
This is how to make a bootable NTFS usb drive for Windows 10

CREDIT FOR UEFI BOOT: [Rufus Team](https://github.com/pbatard/rufus)

## Enable Kernel Extensions
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

Now list disks again:
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

This will take a while, so using verbose so you can see progress:
```
cp -rv /Volumes/win_10_pro_x64_vl/* /Volumes/ntfs/
```

## Unmount USB disks
```
sudo umount /Volumes/ntfs
diskutil umount /Volumes/UEFI_NTFS
```

## Load USB on computer
Once ejected/unmounted from mac and placed into your computer, you load the UEFI boot menu for your motherboard/computer and select your USB drive Partition 2 and it should boot. Its a little ghetto, but works and contributions are welcome.