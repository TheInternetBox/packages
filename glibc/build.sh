#!/bin/bash

set -e

cd build

CFLAGS="$COMMON_CFLAGS" ../source/configure \
  --prefix=/usr \
  --host=$LFS_TARGET \
  --build=$(../source/scripts/config.guess) \
  --enable-kernel=5.15 \
  --disable-profile \
  --enable-bind-now \
  --enable-stack-protector=all \
  --with-headers=$LFS/usr/include

sudo make -j$(nproc)
sudo make DESTDIR=$LFS install
