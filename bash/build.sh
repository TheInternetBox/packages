#!/bin/bash

set -e

cd build

CFLAGS="$COMMON_CFLAGS" CPPFLAGS="$COMMON_CFLAGS" ../source/configure \
  --prefix=$LFS/usr \
  --build=${LFS_HOST} \
  --host=${LFS_TARGET} \
  --with-curses \
  --without-bash-malloc \
  --with-installed-readline

sudo make -j$(nproc)
sudo make install
