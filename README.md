# Internet Box Packages

This repository tracks the packages used for Internet Box.

Each directory contains a `source` directory, which is a git
submodule to the source of the upstream package. Also contained
in each package direcotry is the `build.sh` script, which should
build the package targeting `LFS_TARGET` (target triple),
runnable from `LFS_HOST` (host triple), and install into `LFS`
(the root filesystem)

The root-level `build.sh` takes the three variables above during
the system image build process and populates $LFS with the packages.

Dependencies are managed by the order of compilation in `build.sh`

## Currently tracked packages:

- bash
- readline
- ncurses
- glibc
