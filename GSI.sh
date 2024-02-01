#!/bin/bash

# Set locale to "C" for consistent behavior
export LC_ALL=C

# LineageOS GSI Build Script

# Install build packages
sudo apt update
sudo apt -y install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev libelf-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python3

# Create directories
mkdir -p ~/bin
mkdir -p ~/android/lineage-gsi

# Install repo command
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
sudo cp ~/bin/repo /usr/bin/repo
sudo chmod a+x ~/bin/repo
sudo chmod a+x /usr/bin/repo

# Initialize LineageOS GSI source repository
cd ~/android/lineage-gsi
repo init -u https://github.com/LineageOS/android.git -b lineage-18.1
repo sync

# Set up ccache
echo 'export USE_CCACHE=1' >> ~/.bashrc
echo 'export CCACHE_EXEC=/usr/bin/ccache' >> ~/.bashrc
source ~/.bashrc

# Configure build environment
source build/envsetup.sh

# Choose the target for GSI (e.g., arm64, arm, etc.)
lunch lineage_arm64-userdebug

# Build LineageOS GSI
mka systemimage -j8
