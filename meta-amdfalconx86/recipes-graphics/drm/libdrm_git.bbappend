FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amdfalconx86 = " file://0001-drm-add-libdrm_amdgpu.patch \
				file://0002-drm-add-tests-amdgpu.patch \
				file://0003-tests-also-install-tests-app.patch \
"

SRCREV_amdfalconx86 = "0d78b37b1cac304ce5e84d1207f0a43abd29c000"
PV_amdfalconx86 = "2.4.60+git${SRCPV}"

EXTRA_OECONF_append_amdfalconx86 = " --enable-amdgpu \
				     --enable-radeon \
"

FILES_${PN}-amdgpu = "${libdir}/libdrm_amdgpu.so.*"

do_install_append_amdfalconx86() {
	cp ${S}/include/drm/amdgpu_drm.h ${D}/usr/include/libdrm
}
