#!/bin/bash

set -e

TOPDIR=$(pwd)
LFS=${LFS:-$(mktemp -d /tmp/lfs.XXXXX)}
LFS_HOST=${LFS_HOST:-x86_64-pc-linux-gnu}
LFS_TARGET=${LFS_TARGET:-aarch64-linux-gnu}

COMMON_CFLAGS="-O2 -fstack-protector-all -pie -fPIE -D_FORTIFY_SOURCE=2"
TARGET_CFLAGS="-march=armv8-a+crc -mcpu=cortex-a72 -mtune=cortex-a72"

function build() {
  echo Building $1
  cd $TOPDIR/$1

  mkdir -p build
  sudo env LFS=$LFS LFS_HOST=$LFS_HOST LFS_TARGET=$LFS_TARGET COMMON_CFLAGS="$COMMON_CFLAGS" TARGET_CFLAGS="$TARGET_CFLAGS" ./build.sh
}

# We can assume that the $LFS environment has kernel headers in most cases, however CI needs it populated
# Kernel Headers
if [[ "$(basename $LFS)" =~ ^lfs.* ]]; then
  DEFCONFIG="rpi_cm4_io_router_defconfig"
  KBUILD_BUILD_TIMESTAMP='' make -C ../../boot-image/linux ARCH=arm64 CC="ccache clang" LLVM=1 CROSS_COMPILE=aarch64-linux-gnu- ${DEFCONFIG}
  KBUILD_BUILD_TIMESTAMP='' sudo make -C ../../boot-image/linux ARCH=arm64 CC="ccache clang" LLVM=1 CROSS_COMPILE=aarch64-linux-gnu- INSTALL_HDR_PATH=$LFS/usr headers_install
fi

# glibc must come first
build glibc

build ncurses
build readline
build bash
