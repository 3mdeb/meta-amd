DESCRIPTION = "Implements VDPAU library"
HOMEPAGE = "http://people.freedesktop.org"
LICENSE = "MIT"
DEPENDS = "xtrans libx11 libxext libice libsm libxscrnsaver libxt \
	   libxmu libxpm libxau libxfixes libxcomposite libxrender \
	   libxcursor libxdamage libfontenc libxfont libxft libxi \
	   libxinerama libxrandr libxres libxtst libxv libxvmc \
	   libxxf86dga libxxf86vm libdmx libpciaccess libxkbfile \
	   dri2proto \
	   "
LIC_FILES_CHKSUM = "file://COPYING;md5=83af8811a28727a13f04132cc33b7f58"

SRC_URI = "http://people.freedesktop.org/~aplattner/vdpau/libvdpau-${PV}.tar.gz"
SRC_URI[md5sum] = "cb81b0c3b7d32b2b2a51894ef05b95ce"
SRC_URI[sha256sum] = "24dc08467ce8c59d6cfbf0d34d2dd1f86b4ff62e90777e0a8f513c5c9de9bce0"

inherit autotools pkgconfig

S = "${WORKDIR}/libvdpau-${PV}"

FILES_${PN} += "${libdir}/vdpau/libvdpau_nouveau.so.* \
		${libdir}/vdpau/libvdpau_r600.so.* \
		${libdir}/vdpau/libvdpau_radeonsi.so.* \
		${libdir}/vdpau/libvdpau_trace.so.* \
	       "

FILES_${PN}-dev += "${libdir}/vdpau/libvdpau_nouveau.so \
		    ${libdir}/vdpau/libvdpau_nouveau.la \
		    ${libdir}/vdpau/libvdpau_r600.so \
		    ${libdir}/vdpau/libvdpau_r600.la \
		    ${libdir}/vdpau/libvdpau_radeonsi.so \
		    ${libdir}/vdpau/libvdpau_radeonsi.la \
		    ${libdir}/vdpau/libvdpau_trace.so \
		    ${libdir}/vdpau/libvdpau_trace.la \
		   "

FILES_${PN}-dbg += "${libdir}/vdpau/.debug"

EXTRA_OECONF += "--enable-dri2"
