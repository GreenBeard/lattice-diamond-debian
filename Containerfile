FROM debian:12

RUN mkdir -p /work/lattice-diamond-3.13-3.13.0
COPY ./diamond_3_13-base-56-2-x86_64-linux.rpm /work/lattice-diamond-3.13-3.13.0

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  cpio \
  patchelf \
  python3 \
  rpm2cpio

COPY ./00_prep.sh /work/lattice-diamond-3.13-3.13.0/00_prep.sh
RUN /work/lattice-diamond-3.13-3.13.0/00_prep.sh /work/lattice-diamond-3.13-3.13.0

COPY ./01_fix_rpath.py /work/lattice-diamond-3.13-3.13.0/01_fix_rpath.py
RUN /work/lattice-diamond-3.13-3.13.0/01_fix_rpath.py /work/lattice-diamond-3.13-3.13.0/pkgcontents

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  devscripts \
  dpkg-dev \
  libatk1.0-0 \
  libc6 \
  libgl1 \
  libglib2.0-0 \
  libgstreamer-plugins-base1.0-0 \
  libgstreamer1.0-0 \
  libice6 \
  libpangoxft-1.0-0 \
  libpulse-mainloop-glib0 \
  libpulse0 \
  libsm6 \
  libsqlite3-0 \
  libusb-0.1-4 \
  libuuid1 \
  libx11-6 \
  libxau6 \
  libxext6 \
  libxi6 \
  libxml2 \
  libxrender1 \
  libxss1 \
  libxt6

COPY ./02_build.sh /work/lattice-diamond-3.13-3.13.0/02_build.sh
COPY ./debian /work/lattice-diamond-3.13-3.13.0/debian
RUN /work/lattice-diamond-3.13-3.13.0/02_build.sh /work/lattice-diamond-3.13-3.13.0
