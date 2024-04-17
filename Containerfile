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
  dpkg-dev

RUN DEBIAN_FRONTEND=noninteractive dpkg --add-architecture i386
RUN DEBIAN_FRONTEND=noninteractive apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  libatk1.0-0:amd64 \
  libc6:amd64 \
  libc6:i386 \
  libgdk-pixbuf-2.0-0:amd64 \
  libgl1:amd64 \
  libglib2.0-0:amd64 \
  libgstreamer-plugins-base1.0-0:amd64 \
  libgstreamer1.0-0:amd64 \
  libgtk2.0-0:amd64 \
  libice6:amd64 \
  libpango-1.0-0:amd64 \
  libpangoxft-1.0-0:amd64 \
  libpulse-mainloop-glib0:amd64 \
  libpulse0:amd64 \
  libsm6:amd64 \
  libsqlite3-0:amd64 \
  libusb-0.1-4:amd64 \
  libuuid1:amd64 \
  libx11-6:amd64 \
  libx11-6:i386 \
  libxau6:amd64 \
  libxcb-shape0:amd64 \
  libxcb-xinerama0:amd64 \
  libxcb-xkb1:amd64 \
  libxcomposite1:amd64 \
  libxext6:amd64 \
  libxext6:i386 \
  libxft2:i386 \
  libxi6:amd64 \
  libxinerama1:amd64 \
  libxml2:amd64 \
  libxml2:i386 \
  libxrender1:amd64 \
  libxrender1:i386 \
  libxss1:amd64 \
  libxt6:amd64

COPY ./02_build.sh /work/lattice-diamond-3.13-3.13.0/02_build.sh
COPY ./debian /work/lattice-diamond-3.13-3.13.0/debian
RUN /work/lattice-diamond-3.13-3.13.0/02_build.sh /work/lattice-diamond-3.13-3.13.0
