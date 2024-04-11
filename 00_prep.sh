#!/usr/bin/env bash

set -eu

workdir="$1"

cd "${workdir}"
echo "cfa787daee5690f16259c19794abdac5763c8cc14a1e8a968c55fdd1def629d2 ./diamond_3_13-base-56-2-x86_64-linux.rpm" | sha256sum -c -

mkdir "pkgcontents"
cd "pkgcontents"

rpm2cpio ../diamond_3_13-base-56-2-x86_64-linux.rpm | cpio -idm

tar_archives=(
  "usr/local/diamond/3.13/bin/bin.tar.gz"
  "usr/local/diamond/3.13/cae_library/cae_library.tar.gz"
  "usr/local/diamond/3.13/data/data.tar.gz"
  "usr/local/diamond/3.13/embedded_source/embedded_source.tar.gz"
  "usr/local/diamond/3.13/examples/examples.tar.gz"
  "usr/local/diamond/3.13/ispfpga/ispfpga.tar.gz"
  "usr/local/diamond/3.13/modeltech/modeltech.tar.gz"
  "usr/local/diamond/3.13/synpbase/synpbase.tar.gz"
  "usr/local/diamond/3.13/tcltk/tcltk.tar.gz"
)

for tar_archive in "${tar_archives[@]}"; do
  pushd "$(dirname "${tar_archive}")" >/dev/null
  tar -xzf "$(basename "${tar_archive}")"
  rm "$(basename "${tar_archive}")"
  popd >/dev/null
done

# Remove broken symlink
rm ./usr/local/diamond/3.13/modeltech/linuxloem/VisualizerRls/bin/.debug
