#!/bin/bash

set -e

cd build

LDFLAGS=-L$LFS/usr CFLAGS="$COMMON_CFLAGS" CPPFLAGS="$COMMON_CFLAGS" ../source/configure \
  --prefix=$LFS/usr \
  --build=${LFS_HOST} \
  --host=${LFS_TARGET} \
  --with-curses \
  --disable-static

sudo make SHLIB_LIBS="-lncursesw" -j$(nproc)
sudo make install
