#!/usr/bin/env sh

set -eu

workdir="$1"

cd "${workdir}"

dpkg-buildpackage -b -us -uc -z1
