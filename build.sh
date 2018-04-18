#!/bin/bash

# Date format, used in the image file name
mydate=`date +%Y%m%d-%H%M`

# Location of the build environment, where the image will be mounted during build
ourpath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
buildenv="$ourpath/BuildEnv"

# Buildroot settings
buildroot_repo="https://github.com/buildroot/buildroot.git"
buildroot_branch="2018.02.1"
buildroot_config="do-bootstrap_defconfig"

##############################
# No need to edit under this #
##############################

# Basic function we use to make sure we did not fail
runtest() {
  if [ $1 -ne 0 ]; then
    echo "Build Failed!"
    rm -rf "$ourpath/BuildEnv" "$ourpath/.build" "$ourpath/output"
    exit 1
  fi
}

# Are we asking for a clean? If so, reset the env
if [[ "$1" == "clean" ]]; then
  echo "BUILDROOT-BUILDER: Cleaning build environment..."
  rm -rf "$ourpath/BuildEnv" "$ourpath/.build" "$ourpath/output"
  echo "BUILDROOT-BUILDER: Cleaning complete!"
  exit 0
fi

# make sure no builds are in process (which should never be an issue)
if [ -e ./.build ]; then
	echo "BUILDROOT-BUILDER: Build already in process, aborting"
	exit 1
else
	touch ./.build
fi

mkdir -p $buildenv
cd $buildenv

# Buildroot base
echo "BUILDROOT-BUILDER: Cloning Buildroot..."
git clone $buildroot_repo -b $buildroot_branch --depth 1 ./buildroot
cd buildroot
runtest $?

# Export our external device config
export BR2_EXTERNAL="$ourpath/do-bootstrap"

# Do the build
echo "BUILDROOT-BUILDER: Building Buildroot..."
make $buildroot_config
make -j`getconf _NPROCESSORS_ONLN`
runtest $?

# For each board, generate our images
echo "BUILDROOT-BUILDER: Copying image"
savedir="$ourpath/output/$mydate"
mkdir -p $savedir
mv $buildenv/buildroot/output/images/bzImage $savedir/kernel
mv $buildenv/buildroot/output/images/rootfs.cpio.xz $savedir/initrd

echo "BUILDROOT-BUILDER: Cleaning Up"
rm $ourpath/.build
rm -rf $buildenv
echo "BUILDROOT-BUILDER: Finished!"
exit 0
