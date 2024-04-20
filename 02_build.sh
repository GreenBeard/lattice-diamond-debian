#!/usr/bin/env sh

set -eu

workdir="$1"

cd "${workdir}"

dpkg-buildpackage -a amd64 --build=any,all -us -uc -z1
dpkg-buildpackage -a i386 --build=any -us -uc -z1
