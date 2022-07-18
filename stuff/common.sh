#!/bin/sh

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
    patch -p1 < $1
}

cleanup() {
	if [[ -d usr ]]; then
		mv usr/* .
	fi
	rm -r share/libexec
	rm -r share/{doc,info}
}
