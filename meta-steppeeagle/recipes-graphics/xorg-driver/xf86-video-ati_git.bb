require recipes-graphics/xorg-driver/xorg-driver-video.inc

SUMMARY = "X.Org X server -- ATI integrated graphics chipsets driver"

DESCRIPTION = "xf86-video-ati is an Xorg driver for Intel integrated	\
graphics chipsets. The driver supports depths 8, 15, 16 and 24. On	\
some chipsets, the driver supports hardware accelerated 3D via the	\
Direct Rendering Infrastructure (DRI)."

LIC_FILES_CHKSUM = "file://COPYING;md5=aabff1606551f9461ccf567739af63dc"

DEPENDS += "virtual/libx11 drm dri2proto glproto \
	    virtual/libgl xineramaproto libpciaccess \
	    udev glamor-egl"

SRCREV = "48d3dbc8a0d3bfde88f46e402e530438f9317715"
PV = "7.3.99+git${SRCPV}"
PR = "${INC_PR}.1"

EXTRA_OECONF += "--enable-udev --enable-glamor"

SRC_URI = " \
	   git://anongit.freedesktop.org/git/xorg/driver/xf86-video-ati \
	   file://0001-radeon-add-support-for-Mullins.patch \
	   file://0002-radeon-kms-add-Mullins-pci-ids.patch \
	   "

PATCHTOOL = "git"

S = "${WORKDIR}/git"

RDEPENDS_${PN} += "libgbm-gallium \
		   mesa-driver-radeon \
		   mesa-driver-radeonsi \
		   mesa-driver-swrast \
		  "

COMPATIBLE_HOST = '(i.86|x86_64).*-linux'
