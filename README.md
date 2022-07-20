# Create Windows 10 Bootable USB on macOS Apple Silicon M1
This is how to make a bootable NTFS usb drive for Windows 10

## Enable Kernel Extensions
You want to enable: Allow user management of kernel extensions from identified developers: Allow installation of software that uses legacy kernel extensions.

[Apple Support Link](https://support.apple.com/guide/mac-help/macos-recovery-a-mac-apple-silicon-mchl82829c17/mac)

OR

[Check out this video from Paragon](https://www.youtube.com/watch?v=0EXmDmHm6eg)

## Install brew
[Brew Installation Link](https://brew.sh)

OR

```
# Run in the terminal
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install ntfs-3g & macfuse via brew
Run the following commands in the terminal and reboot to be safe that the extensions are loaded.
```
# Run in terminal
brew tap gromgit/homebrew-fuse
brew install --cask macfuse
brew install ntfs-3g-mac
```

## Partition USB drive
Insert USB drive and run the following commands in the terminal

### List disk and get /dev disk number
List disk and find your usb drive. It will be an (external, physical) and look for name that is mounted on Desktop
``` 
diskutil list
```

Example: On Desktop name is Windows
```
/dev/disk4 (external, physical):
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *32.1 GB    disk4
   1:               Windows_NTFS Windows                 32.1 GB    disk4s1
```