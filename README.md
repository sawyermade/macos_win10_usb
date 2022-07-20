# Create Windows 10 Bootable USB on macOS Apple Silicon M1
This is how to make a bootable NTFS usb drive for Windows 10

## Install brew
[Brew Installation Link](https://brew.sh)

OR

```
# Run in the terminal
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Enable Kernel Extensions
You want to enable: Allow user management of kernel extensions from identified developers: Allow installation of software that uses legacy kernel extensions.

[Apple Support Link](https://support.apple.com/guide/mac-help/macos-recovery-a-mac-apple-silicon-mchl82829c17/mac)

OR

[Check out this video from Paragon](https://www.youtube.com/watch?v=0EXmDmHm6eg)

## Install ntfs-3g & macfuse via brew
Run the following commands in the terminal and reboot to be safe that the extensions are loaded.
```
# Run in terminal
brew tap gromgit/homebrew-fuse
brew install --cask macfuse
brew install ntfs-3g-mac
```