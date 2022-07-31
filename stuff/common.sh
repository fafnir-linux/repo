#!/bin/sh

umask 0022
unalias -a

pushd() { command pushd "$1" > /dev/null; }
popd() { command popd "$1" > /dev/null; }

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

unset CROSS_COMPILE

if [[ -n $STAGE ]] && [[ $STAGE = 0 ]]; then
	xconfflags="--host=$($CC -dumpmachine)"
	#xconfflags="$xconfflags --with-sysroot=%rootfs"
	CROSS_COMPILE=yes
fi

inst() {
    local action=$@
    if [[ -z $action ]]; then
        action="install"
    fi
    make DESTDIR=%dest $action
}

apply_patch() {
    echo "applying patch $(basename $1)"
    $PATCH -p1 < $1
}

apply_patches() {
	for patch in $1/*; do
		apply_patch $patch
	done
}
