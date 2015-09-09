FILESEXTRAPATHS_prepend_amdfalconx86 := "${THISDIR}/${PN}:"

SRCREV_amdfalconx86 = "2a9ab75914500b4d06b5133932521ce5edbf415c"
LIC_FILES_CHKSUM_amdfalconx86 = "file://docs/license.html;md5=6a23445982a7a972ac198e93cc1cb3de"
PV_amdfalconx86 = "10.7.0+git${SRCPV}"
DEPENDS_append_amdfalconx86 = " python-mako-native libdrm nettle"
GALLIUMDRIVERS_append_amdfalconx86 = ",r300,r600,radeonsi"
GALLIUMDRIVERS_LLVM_amdfalconx86 = "r300,svga${@',${GALLIUMDRIVERS_LLVM33}' if ${GALLIUMDRIVERS_LLVM33_ENABLED} else ',nouveau'}"
MESA_LLVM_RELEASE_amdfalconx86 = "3.7.0"

SRC_URI_amdfalconx86 = "git://anongit.freedesktop.org/git/mesa/mesa;branch=amdgpu"

# Install override from mesa.inc
do_install_append_amdfalconx86() {
	cp ${S}/include/EGL/eglplatform.h ${D}${includedir}/EGL/eglplatform.h
}

EXTRA_OECONF_append_amdfalconx86 = " \
		 --enable-r600-llvm-compiler \
		 --enable-llvm-shared-libs \
		 --disable-xvmc \
		 --enable-texture-float \
		"

