# Lattice Diamond 3.13.0 Debian package

Not all dependencies are satisified (such as libtiff3, and python2), but
everything that was satisifiable without rebuilding shared libraries (such as
wxWidgets) should be done.

The package is currently not using `sbuild` as I haven't ever done that before
so things such as build dependencies aren't listed, and using a container was
easier to avoid issues than figuring out `sbuild` for now.
