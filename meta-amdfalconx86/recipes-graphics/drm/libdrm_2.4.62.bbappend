FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_amdfalconx86 = " file://0001-drm-add-libdrm_amdgpu.patch \
				file://0002-drm-add-tests-amdgpu.patch \
"

EXTRA_OECONF_append_amdfalconx86 = " --enable-amdgpu \
				     --enable-radeon \
"

FILES_${PN}-amdgpu = "${libdir}/libdrm_amdgpu.so.*"

do_install_append_amdfalconx86() {
	cp ${S}/include/drm/amdgpu_drm.h ${D}/usr/include/libdrm
}
