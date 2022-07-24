#!/bin/sh

CC=gcc
PATCH=patch

if [[ -f %rootfs/bin/gcc ]]; then
	CC=%rootfs/bin/gcc
fi

if [[ -f %rootfs/bin/patch ]]; then
	PATCH=%rootfs/bin/patch
fi

export CC=$CC HOSTCC=$CC

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
