#!/bin/sh

CC=gcc
CXX=g++
MAKE=make
PATCH=patch

if [[ -f %rootfs/bin/gcc ]]; then
	CC=%rootfs/bin/gcc
fi

if [[ -f %rootfs/bin/g++ ]]; then
	CXX=%rootfs/bin/g++
fi

if [[ -f %rootfs/bin/make ]]; then
	MAKE=%rootfs/bin/make
fi

if [[ -f %rootfs/bin/patch ]]; then
	PATCH=%rootfs/bin/patch
fi

export CC=$CC CXX=$CXX HOSTCC=$CC HOSTCXX=$CXX

alias make=$MAKE

xconfflags=""

if [[ -n $STAGE ]] && [[ $STAGE = 0 ]]; then
	xconfflags="--build=$($CC -dumpmachine)"
fi

inst() {
    local action=$@
    if [[ -z $action ]]; then
        action="install"
    fi
    $MAKE DESTDIR=%dest $action
}

apply_patch() {
    echo "applying patch $(basename $1)"
    $PATCH -p1 < $1
}
