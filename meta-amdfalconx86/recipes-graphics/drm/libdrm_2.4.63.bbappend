FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

EXTRA_OECONF_append_amdfalconx86 = " --enable-amdgpu \
				     --enable-radeon \
"

FILES_${PN}-amdgpu = "${libdir}/libdrm_amdgpu.so.*"

do_install_append_amdfalconx86() {
	cp ${S}/include/drm/amdgpu_drm.h ${D}/usr/include/libdrm
}
