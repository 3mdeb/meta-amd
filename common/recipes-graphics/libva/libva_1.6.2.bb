SUMMARY = "Dummy package for dependency resolution between Mesa and Libva"
DESCRIPTION = "There exists a cyclic dependency between Mesa and Libva \
	       when libva is built with egl/glx enabled and mesa \
	       is enabling its vaapi backend. This package strives \
	       to cover up the dependency chain."

HOMEPAGE = "http://www.freedesktop.org/wiki/Software/vaapi"
BUGTRACKER = "https://bugs.freedesktop.org"

SECTION = "x11"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=2e48940f94acb0af582e5ef03537800f"

inherit autotools pkgconfig

SRC_URI = "http://www.freedesktop.org/software/vaapi/releases/libva/${BP}.tar.bz2"

SRC_URI[md5sum] = "430cc2742df60204f121409c06039d09"
SRC_URI[sha256sum] = "c417f09cdeef549e54f4be5f9876026513afeac395c5be28750b431d848c8bd0"

DEPENDS = "libdrm"

EXTRA_OECONF = "--disable-dummy-driver --disable-egl --disable-glx"

PACKAGECONFIG ??= "${@bb.utils.contains("DISTRO_FEATURES", "x11", "x11", "", d)} \
                   ${@bb.utils.contains("DISTRO_FEATURES", "wayland", "wayland", "", d)}"
PACKAGECONFIG[x11] = "--enable-x11,--disable-x11,virtual/libx11 libxext libxfixes"
PACKAGECONFIG[wayland] = "--enable-wayland,--disable-wayland,wayland"

PACKAGES =+ "${PN}-x11 ${PN}-tpi ${PN}-wayland"

RDEPENDS_${PN}-tpi =+ "${PN}"
RDEPENDS_${PN}-x11 =+ "${PN}"

FILES_${PN}-dbg += "${libdir}/dri/.debug"

FILES_${PN}-x11 =+ "${libdir}/${PN}-x11*${SOLIBS}"
FILES_${PN}-tpi =+ "${libdir}/${PN}-tpi*${SOLIBS}"
FILES_${PN}-wayland =+ "${libdir}/${PN}-wayland*${SOLIBS}"
