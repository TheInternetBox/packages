#!/bin/bash

set -e

cd build

CFLAGS="$COMMON_CFLAGS" CPPFLAGS="$COMMON_CFLAGS" ../source/configure \
  --prefix=$LFS/usr \
  --build=${LFS_HOST} \
  --host=${LFS_TARGET} \
  --libdir=$LFS/usr/lib \
  --with-shared \
  --without-debug \
  --enable-pc-files \
  --without-manpages \
  --with-default-terminfo-dir=/usr/share/terminfo \
  --enable-widec \
  --without-normal \
  --with-pkg-config-libdir=$LFS/usr/lib/pkgconfig \
  --disable-stripping

sudo make
sudo make install

for lib in ncurses form panel menu ; do
    sudo rm -vf                    $LFS/usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" | sudo tee $LFS/usr/lib/lib${lib}.so
    sudo ln -sfv ${lib}w.pc        $LFS/usr/lib/pkgconfig/${lib}.pc
done

sudo ln -sfv libncursesw.so $LFS/usr/lib/libcurses.so
