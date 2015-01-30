DESCRIPTION = "VDPAU info tool"
HOMEPAGE = "http://people.freedesktop.org"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://COPYING;md5=5b6e110c362fe46168199f3490e52c3c"

SRC_URI = "git://people.freedesktop.org/~aplattner/vdpauinfo;tag=vdpauinfo-0.1"
S = "${WORKDIR}/git"

inherit autotools pkgconfig

DEPENDS += "virtual/libx11 libvdpau"

RDEPENDS_${PN} += "libvdpau-mesa"
