FILESEXTRAPATHS_prepend_amdfalconx86 := "${THISDIR}/${PN}:"

SRCREV_amdfalconx86 = "b9b19162ee3f8d68be76b71adf2a290cbb675660"
LIC_FILES_CHKSUM_amdfalconx86 = "file://docs/license.html;md5=6a23445982a7a972ac198e93cc1cb3de"
PV_amdfalconx86 = "11.0.8+git${SRCPV}"
DEPENDS_append_amdfalconx86 = " python-mako-native libdrm nettle"
GALLIUMDRIVERS_append_amdfalconx86 = ",r300,r600,radeonsi"
GALLIUMDRIVERS_LLVM_amdfalconx86 = "r300,svga${@',${GALLIUMDRIVERS_LLVM33}' if ${GALLIUMDRIVERS_LLVM33_ENABLED} else ',nouveau'}"
MESA_LLVM_RELEASE_amdfalconx86 = "3.7.1"

SRC_URI_amdfalconx86 = "\
			git://anongit.freedesktop.org/git/mesa/mesa;branch=11.0 \
"

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

