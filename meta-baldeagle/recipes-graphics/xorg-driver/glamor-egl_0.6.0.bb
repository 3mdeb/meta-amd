require recipes-graphics/xorg-driver/xorg-driver-common.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=c7f5e33031114ad132cb03949d73a8a8"

SRC_URI[md5sum] = "b3668594675f71a75153ee52dbd35535"
SRC_URI[sha256sum] = "66531b56e6054eb53daa7bd57eb6358a7ead1b84f63419606e69d1092365e5c9"

S = "${WORKDIR}/${PN}-${PV}"

inherit autotools pkgconfig

EXTRA_OECONF += "--prefix=${prefix} \
		 --sysconfdir=${sysconfdir} \
		 --localstatedir=${localstatedir} \
		 --enable-glamor-gles2 \
		 --enable-glx-tls"

FILES_${PN} += "${datadir}/X11/xorg.conf.d ${libdir}/xorg/modules/lib*.so"
FILES_${PN}-dbg += "${libdir}/xorg/modules/.debug"
