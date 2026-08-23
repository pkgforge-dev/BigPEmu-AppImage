#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

echo "Getting app..."
echo "---------------------------------------------------------------"
case "$ARCH" in # they use 64 and ARM64 for tar.gz links
	x86_64)  z_arch=64;;
	aarch64) z_arch=ARM64;;
esac
wget https://www.richwhitehouse.com/jaguar/builds/BigPEmu_Linux${z_arch}_v1221.tar.gz
tar -xvzf ./*.tar.gz --strip-components=1
rm -f ./*.tar.gz bigpemu-icon.png make_desktop.sh *.txt 
mkdir -p ./AppDir/bin
mv -v Data plugins Scripts Strings bigpemu ./AppDir/bin
