SUMMARY = "X.Org X server -- AMD graphics chipsets driver"

DESCRIPTION = "xf86-video-amd is an Xorg driver for AMD integrated	\
graphics chipsets. The driver supports depths 8, 15, 16 and 24. On	\
some chipsets, the driver supports hardware accelerated 3D via the	\
Direct Rendering Infrastructure (DRI)."

require recipes-graphics/xorg-driver/xorg-driver-video.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=aabff1606551f9461ccf567739af63dc"

DEPENDS += "virtual/libx11 drm dri2proto glproto \
	    virtual/libgl xineramaproto libpciaccess \
"

PACKAGECONFIG[udev] = "--enable-udev,--disable-udev,udev"
PACKAGECONFIG[glamor] = "--enable-glamor,--disable-glamor"

SRC_URI_radeon = "git://anongit.freedesktop.org/git/xorg/driver/xf86-video-ati"
SRCREV_radeon = "99cb8c3faf1a4ce368b7500f17a2a7868c15e8e8"
PV_radeon = "radeon-7.6.1"
PACKAGECONFIG_append_radeon = " udev glamor"

SRC_URI_amdgpu = "git://anongit.freedesktop.org/xorg/driver/xf86-video-amdgpu;branch=1.0"
SRCREV_amdgpu = "d68b3073a9627a81b047e9bdd4b5569359df898d"
PV_amdgpu = "amdgpu-1.0.1"
PACKAGECONFIG_append_amdgpu = " udev glamor"

PV = "git${SRCPV}"

S = "${WORKDIR}/git"

RDEPENDS_${PN} += "mesa-driver-radeon \
		   mesa-driver-radeonsi \
		   mesa-driver-swrast \
"

COMPATIBLE_HOST = '(i.86|x86_64).*-linux'

PACKAGES += "${PN}-conf"
FILES_${PN}-conf = "${datadir}/X11"
