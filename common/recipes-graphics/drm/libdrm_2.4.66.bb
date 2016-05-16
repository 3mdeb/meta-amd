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
DEPENDS = "libpthread-stubs udev libpciaccess freetype libxext cairo fontconfig libxrender libpng pixman"

SRC_URI = "http://dri.freedesktop.org/libdrm/${BP}.tar.bz2 \
           file://0001-tests-also-install-tests-app.patch \
	   file://0002-amdgpu-drop-address-patching-logics.patch \
	   file://0003-amdgpu-validate-user-memory-for-userptr.patch \
	   file://0004-amdgpu-add-semaphore-support.patch \
	   file://0005-amdgpu-list-each-entry-safely-for-sw-semaphore-when-.patch \
	   file://0006-amdgpu-fix-for-submition-with-no-ibs.patch \
"
SRC_URI[md5sum] = "c6809c48538d6e5999588832045ff014"
SRC_URI[sha256sum] = "79cb8e988749794edfb2d777b298d5292eff353bbbb71ed813589e61d2bc2d76"

inherit autotools pkgconfig

EXTRA_OECONF += "--disable-cairo-tests \
                 --enable-omap-experimental-api \
                 --enable-install-test-programs \
                 --disable-manpages \
                 --disable-valgrind \
		 --enable-amdgpu \
		 --enable-radeon \
                "

ALLOW_EMPTY_${PN}-drivers = "1"
PACKAGES =+ "${PN}-tests ${PN}-drivers ${PN}-radeon ${PN}-nouveau ${PN}-omap \
             ${PN}-intel ${PN}-exynos ${PN}-kms ${PN}-freedreno ${PN}-amdgpu"

RRECOMMENDS_${PN}-drivers = "${PN}-radeon ${PN}-nouveau ${PN}-omap ${PN}-intel \
                             ${PN}-exynos ${PN}-freedreno ${PN}-amdgpu"

FILES_${PN}-tests = "${bindir}/dr* ${bindir}/mode* ${bindir}/*test"
FILES_${PN}-radeon = "${libdir}/libdrm_radeon.so.*"
FILES_${PN}-nouveau = "${libdir}/libdrm_nouveau.so.*"
FILES_${PN}-omap = "${libdir}/libdrm_omap.so.*"
FILES_${PN}-intel = "${libdir}/libdrm_intel.so.*"
FILES_${PN}-exynos = "${libdir}/libdrm_exynos.so.*"
FILES_${PN}-kms = "${libdir}/libkms*.so.*"
FILES_${PN}-freedreno = "${libdir}/libdrm_freedreno.so.*"
FILES_${PN}-amdgpu = "${libdir}/libdrm_amdgpu.so.*"

do_install_append_amd() {
	cp ${S}/include/drm/amdgpu_drm.h ${D}/usr/include/libdrm
}
