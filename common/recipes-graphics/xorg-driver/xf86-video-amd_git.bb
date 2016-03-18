SUMMARY = "X.Org X server -- AMD graphics chipsets driver"

DESCRIPTION = "xf86-video-amd is an Xorg driver for AMD integrated	\
graphics chipsets. The driver supports depths 8, 15, 16 and 24. On	\
some chipsets, the driver supports hardware accelerated 3D via the	\
Direct Rendering Infrastructure (DRI)."

require recipes-graphics/xorg-driver/xorg-driver-video.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=aabff1606551f9461ccf567739af63dc"

DEPENDS += "virtual/libx11 drm dri2proto glproto \
	    virtual/libgl xineramaproto libpciaccess \
	    udev glamor-egl \
"

EXTRA_OECONF += "--enable-udev --enable-glamor"

SRC_URI_radeon = "git://anongit.freedesktop.org/git/xorg/driver/xf86-video-ati"
SRCREV_radeon = "xf86-video-ati-7.6.1"
PV_radeon = "radeon-7.6.1"

SRC_URI_amdgpu = "git://anongit.freedesktop.org/xorg/driver/xf86-video-amdgpu;branch=1.0"
SRCREV_amdgpu = "xf86-video-amdgpu-1.0.1"
PV_amdgpu = "amdgpu-1.0.1"

PV = "git${SRCPV}"

S = "${WORKDIR}/git"

RDEPENDS_${PN} += "glamor-egl \
		   mesa-driver-radeon \
		   mesa-driver-radeonsi \
		   mesa-driver-swrast \
"

COMPATIBLE_HOST = '(i.86|x86_64).*-linux'

PACKAGES += "${PN}-conf"
FILES_${PN}-conf = "${datadir}/X11"
