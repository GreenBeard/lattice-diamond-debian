#!/usr/bin/env sh

set -eu

workdir="$1"

cd "$1"

dpkg-buildpackage -us -uc -z1
