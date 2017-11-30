DESCRIPTION = "VDPAU info tool"
HOMEPAGE = "http://people.freedesktop.org"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://COPYING;md5=5b6e110c362fe46168199f3490e52c3c"

SRC_URI = "http://people.freedesktop.org/~aplattner/vdpau/vdpauinfo-${PV}.tar.gz"
SRC_URI[md5sum] = "4eba3e7bf5062b9c245276860493804f"
SRC_URI[sha256sum] = "4054960b7ae618c351ff1ce3e7831b5cbda964ae1fbf9969b7146404d3044bc4"

inherit autotools pkgconfig

DEPENDS += "virtual/libx11 libvdpau mesa"

RDEPENDS_${PN} += "libvdpau-mesa"
