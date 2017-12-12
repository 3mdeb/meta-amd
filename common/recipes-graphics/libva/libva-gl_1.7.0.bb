SUMMARY = "Video Acceleration (VA) API for Linux"
DESCRIPTION = "Video Acceleration API (VA API) is a library (libVA) \
and API specification which enables and provides access to graphics \
hardware (GPU) acceleration for video processing on Linux and UNIX \
based operating systems. Accelerated processing includes video \
decoding, video encoding, subpicture blending and rendering. The \
specification was originally designed by Intel for its GMA (Graphics \
Media Accelerator) series of GPU hardware, the API is however not \
limited to GPUs or Intel specific hardware, as other hardware and \
manufacturers can also freely use this API for hardware accelerated \
video decoding."

HOMEPAGE = "http://www.freedesktop.org/wiki/Software/vaapi"
BUGTRACKER = "https://bugs.freedesktop.org"

SECTION = "x11"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=2e48940f94acb0af582e5ef03537800f"

inherit autotools pkgconfig

SRC_URI = "http://www.freedesktop.org/software/vaapi/releases/libva/libva-${PV}.tar.bz2 \
	   file://0001-disable-tests.patch \
	   file://0002-allow-building-gl-backends-only.patch \
	   file://0003-allow-building-glx-backend-without-x11-enabled.patch"

SRC_URI[md5sum] = "7309097b790de8dbc9641ed6393eab9f"
SRC_URI[sha256sum] = "a689bccbcc81a66b458e448377f108c057d3eee44a2e21a23c92c549dc8bc95f"

DEPENDS = "libdrm virtual/mesa virtual/libgles1 virtual/libgles2"

S = "${WORKDIR}/libva-${PV}"

EXTRA_OECONF = "--disable-dummy-driver --disable-x11 --disable-wayland --disable-drm"

PACKAGECONFIG ??= "${@bb.utils.contains("DISTRO_FEATURES", "opengl", "egl glx", "", d)}"
PACKAGECONFIG[egl] = "--enable-egl,--disable-egl,virtual/egl,libva-x11"
PACKAGECONFIG[glx] = "--enable-glx,--disable-glx,virtual/libgl libx11,libva-x11"

FILES_${PN}-dbg += "${libdir}/dri/.debug"
