#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm libdecor

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
echo "Getting app..."
echo "---------------------------------------------------------------"
case "$ARCH" in # they use AMD64 and ARM64 for the deb links
	x86_64)  z_arch=64;;
	aarch64) z_arch=ARM64;;
esac
wget https://www.richwhitehouse.com/jaguar/builds/BigPEmu_Linux${z_arch}_v121.tar.gz
tar -xvzf BigPEmu_Linux${z_arch}_v121.tar.gz --strip-components=1
rm -f *.tar.gz bigpemu-icon.png make_desktop.sh *.txt 
mkdir -p ./AppDir/bin
mv -v Data plugins Scripts Strings bigpemu ./AppDir/bin
