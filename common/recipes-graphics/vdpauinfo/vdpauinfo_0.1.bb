DESCRIPTION = "VDPAU info tool"
HOMEPAGE = "http://people.freedesktop.org"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://COPYING;md5=5b6e110c362fe46168199f3490e52c3c"

SRC_URI = "http://cgit.freedesktop.org/~aplattner/vdpauinfo/snapshot/vdpauinfo-${PV}.zip"
SRC_URI[md5sum] = "62902c9d5d4417885aa70d05521b8280"
SRC_URI[sha256sum] = "b87dd48b2b3b4fc7e886c6963d8dfe8d4dffa3f7b91768a1376ba3e295c28db7"

inherit autotools pkgconfig

DEPENDS += "virtual/libx11 libvdpau"

RDEPENDS_${PN} += "libvdpau-mesa"
