#!/bin/sh

CC=gcc
CXX=g++
PATCH=patch

if [[ -f %rootfs/bin/gcc ]]; then
	CC=%rootfs/bin/gcc
fi

if [[ -f %rootfs/bin/g++ ]]; then
	CXX=%rootfs/bin/g++
fi

if [[ -f %rootfs/bin/patch ]]; then
	PATCH=%rootfs/bin/patch
fi

export CC=$CC CXX=$CXX HOSTCC=$CC

init_flags() {
	:
}

inst() {
    local action=$*
    if [[ -z $action ]]; then
        action="install"
    fi
    make DESTDIR=%dest $action
}

apply_patch() {
    echo "applying patch $(basename $1)"
    $PATCH -p1 < $1
}
