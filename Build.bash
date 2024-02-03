#!/bin/bash

# Set locale to "C" for consistent behavior
export LC_ALL=C

# CyanogenMod 14 Build Script

# Add ccache configuration
echo 'export USE_CCACHE=1' >> ~/.bashrc
echo 'export CCACHE_EXEC=/usr/bin/ccache' >> ~/.bashrc
source ~/.bashrc

# Install build packages
sudo apt update
sudo apt -y install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python3

# Create directories
mkdir -p ~/bin
mkdir -p ~/android/cm14

# Install repo command
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
sudo cp ~/bin/repo /usr/bin/repo
sudo chmod a+x ~/bin/repo
sudo chmod a+x /usr/bin/repo

# Initialize CyanogenMod 14 source repository
cd ~/android/cm14
repo init -u https://github.com/LineageOS/android.git -b cm-14.1
repo sync

# Remove existing device and vendor repositories
rm -rf device/4013
rm -rf vendor/4013

# Clone updated device and vendor repositories
git clone https://github.com/melekpro/android_device_4013 device/4013
git clone https://github.com/melekpro/android_vendor_4013 vendor/4013
source build/envsetup.sh

# Add lunch combo for userdebug build
echo "add_lunch_combo lineage_4013-userdebug" >> device/4013/vendorsetup.sh

# Clean previous build artifacts
make clean
make clobber

# Start the build
lunch lineage_4013-userdebug
make bacon -j8
