#!/bin/sh
# post-build.sh for DO-Bootstrap

# Generate our version file
BUILD_TIMESTAMP=`date +%Y%m%d-%H%M`
BUILD_BRANCH="$(cd $BR2_EXTERNAL_DO_BS_PATH && cd .. && git rev-parse --abbrev-ref HEAD)"
BUILD_VER="$(cd $BR2_EXTERNAL_DO_BS_PATH && cd .. && git rev-parse --short HEAD)"
echo "$BUILD_BRANCH-$BUILD_VER-$BUILD_TIMESTAMP" > "${TARGET_DIR}/etc/img-release"

exit 0
