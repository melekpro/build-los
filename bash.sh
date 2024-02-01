#!/bin/bash

# LineageOS 15.1 Build Script for Retroid Pocket 2

# Install build dependencies
sudo apt update
sudo apt -y install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python3

# Create directories
mkdir -p ~/bin
mkdir -p ~/android/lineage

# Install repo command
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
sudo cp ~/bin/repo /usr/bin/repo
sudo chmod a+x ~/bin/repo
sudo chmod a+x /usr/bin/repo

# Initialize LineageOS 15.1 source repository
cd ~/android/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-15.1
repo sync

# Clone Retroid Pocket 2 device-specific and vendor code
cd ~/android/lineage
git clone https://github.com/turtleletortue/android_device_retroid_pocket2 device/retroid/pocket2
git clone https://github.com/melekpro/android_vendor_retroid_pocket2 vendor/retroid/pocket2
source build/envsetup.sh

# Add lunch combo for userdebug build
lunch lineage_pocket2-userdebug

# Additional lunch combos
add_lunch_combo aosp_pocket2-user
add_lunch_combo aosp_pocket2-userdebug
add_lunch_combo aosp_pocket2-eng

add_lunch_combo lineage_pocket2-user
add_lunch_combo lineage_pocket2-userdebug
add_lunch_combo lineage_pocket2-eng

add_lunch_combo lineage_atv_pocket2-user
add_lunch_combo lineage_atv_pocket2-userdebug
add_lunch_combo lineage_atv_pocket2-eng

# Start the build with croot and brunch
cd ~/android/lineage
croot && brunch
