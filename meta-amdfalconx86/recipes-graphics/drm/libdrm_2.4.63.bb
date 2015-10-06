SUMMARY = "Userspace interface to the kernel DRM services"
DESCRIPTION = "The runtime library for accessing the kernel DRM services.  DRM \
stands for \"Direct Rendering Manager\", which is the kernel portion of the \
\"Direct Rendering Infrastructure\" (DRI).  DRI is required for many hardware \
accelerated OpenGL drivers."
HOMEPAGE = "http://dri.freedesktop.org"
SECTION = "x11/base"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://xf86drm.c;beginline=9;endline=32;md5=c8a3b961af7667c530816761e949dc71"
PROVIDES = "drm"
DEPENDS = "libpthread-stubs udev libpciaccess"

SRC_URI = "http://dri.freedesktop.org/libdrm/${BP}.tar.bz2 \
           file://installtests.patch "
SRC_URI[md5sum] = "519da97017ea0e2cbea65c972c2be26e"
SRC_URI[sha256sum] = "c7ae43520a9c74ee168a3393c7a6d138342e04d9f821f46c0589547c92a3e79e"

inherit autotools pkgconfig

EXTRA_OECONF += "--disable-cairo-tests \
                 --enable-omap-experimental-api \
                 --enable-install-test-programs \
                 --disable-manpages \
                 --disable-valgrind \
                "

ALLOW_EMPTY_${PN}-drivers = "1"
PACKAGES =+ "${PN}-tests ${PN}-drivers ${PN}-radeon ${PN}-nouveau ${PN}-omap \
             ${PN}-intel ${PN}-exynos ${PN}-kms ${PN}-freedreno"

RRECOMMENDS_${PN}-drivers = "${PN}-radeon ${PN}-nouveau ${PN}-omap ${PN}-intel \
                             ${PN}-exynos ${PN}-freedreno"

FILES_${PN}-tests = "${bindir}/dr* ${bindir}/mode* ${bindir}/*test"
FILES_${PN}-radeon = "${libdir}/libdrm_radeon.so.*"
FILES_${PN}-nouveau = "${libdir}/libdrm_nouveau.so.*"
FILES_${PN}-omap = "${libdir}/libdrm_omap.so.*"
FILES_${PN}-intel = "${libdir}/libdrm_intel.so.*"
FILES_${PN}-exynos = "${libdir}/libdrm_exynos.so.*"
FILES_${PN}-kms = "${libdir}/libkms*.so.*"
FILES_${PN}-freedreno = "${libdir}/libdrm_freedreno.so.*"

