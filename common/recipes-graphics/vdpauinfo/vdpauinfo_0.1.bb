DESCRIPTION = "VDPAU info tool"
HOMEPAGE = "http://people.freedesktop.org"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://COPYING;md5=5b6e110c362fe46168199f3490e52c3c"

SRC_URI = "git://people.freedesktop.org/~aplattner/vdpauinfo"
S = "${WORKDIR}/git"
SRCREV = "e084c3cb43c46aa38392889d523c74de0386075d"

inherit autotools pkgconfig

DEPENDS += "virtual/libx11 libvdpau mesa"

RDEPENDS_${PN} += "libvdpau-mesa"
