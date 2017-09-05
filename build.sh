#!/bin/bash

PrintHelp(){
    echo -e "DO-Bootstrap Initrd.img modifier"
    echo -e "Usage: \n./build.sh stock-initrd.img"
}

# Are we root?
if [ "$(id -u)" != "0" ]
then
    echo "Error: This script must be ran as root!"
    exit 1
fi
if [ ! -e "$1" ]
then
    echo -e "Error, file $1 does not exist!\n"
    PrintHelp
	exit 1
fi

# Start the fun, extract img as it's a gz to Start
gunzip -c $1 > $1.unzip

# Clean and make extract folder
[ -d ./extract ] && rm -rf ./extract
mkdir ./extract

# Extract image
cd ./extract && cpio -id < ../$1.unzip
cd ..

# Cleanup
rm $1.unzip

# Apply Overlay
mkdir ./extract/overlay
cp -R ./overlay/* ./extract/overlay
chown root:root ./extract/overlay
cp -R ./extract/overlay/* ./extract
rm -rf ./extract/overlay

# Build the new image
cd ./extract
find . | cpio --create --format='newc' > ../output/$1.modified.unzip
cd ..
gzip -c ./output/$1.modified.unzip > ./output/$1.modified
rm ./output/$1.modified.unzip
rm -rf ./extract

# We Done
echo "All done! :)"
