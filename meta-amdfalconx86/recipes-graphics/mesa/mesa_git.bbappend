FILESEXTRAPATHS_prepend_amdfalconx86 := "${THISDIR}/${PN}:"

SRCREV_amdfalconx86 = "c1485f4b7d044724b3dbc1011f3c3a8a53132010"
LIC_FILES_CHKSUM_amdfalconx86 = "file://docs/license.html;md5=6a23445982a7a972ac198e93cc1cb3de"
PV_amdfalconx86 = "10.6.0+git${SRCPV}"
DEPENDS_append_amdfalconx86 = " python-mako-native wayland libdrm nettle"
GALLIUMDRIVERS_append_amdfalconx86 = ",r300,r600,radeonsi"
GALLIUMDRIVERS_LLVM_amdfalconx86 = "r300,svga${@',${GALLIUMDRIVERS_LLVM33}' if ${GALLIUMDRIVERS_LLVM33_ENABLED} else ',nouveau'}"
MESA_LLVM_RELEASE_amdfalconx86 = "3.7.0"

SRC_URI_amdfalconx86 = "git://anongit.freedesktop.org/git/mesa/mesa;branch=master \
			file://0001-winsys-radeon-make-radeon_bo_vtbl-static.patch \
			file://0002-gallium-radeon-print-winsys-info-with-R600_DEBUG-inf.patch \
			file://0003-radeonsi-remove-useless-includes.patch \
			file://0004-radeonsi-remove-deprecated-and-useless-registers.patch \
			file://0005-radeonsi-set-an-optimal-value-for-DB_Z_INFO_ZRANGE_P.patch \
			file://0006-winsys-radeon-move-radeon_winsys.h-up-one-directory.patch \
			file://0007-winsys-radeon-add-a-private-interface-for-radeon_sur.patch \
			file://0008-winsys-amdgpu-add-a-new-winsys-for-the-new-kernel-dr.patch \
			file://0009-winsys-amdgpu-add-addrlib-texture-addressing-and-ali.patch \
			file://0010-radeonsi-fix-DRM-version-checks-for-amdgpu-DRM-3.0.0.patch \
			file://0011-radeonsi-add-VI-register-definitions.patch \
			file://0012-radeonsi-add-VI-hardware-support.patch \
			file://0013-radeonsi-add-a-temporary-workaround-for-a-shader-bug.patch \
			file://0014-gallium-radeon-use-VM-for-UVD.patch \
			file://0015-gallium-radeon-use-VM-for-VCE.patch \
			file://0016-gallium-radeon-add-h264-performance-HW-decoder-suppo.patch \
			file://0017-radeon-vce-make-firmware-check-compatible-with-new-f.patch \
			file://0018-radeon-vce-adapt-new-firmware-interface-changes.patch \
			file://0019-radeon-video-add-4K-support-for-decode-encode-parame.patch \
			file://0020-radeon-uvd-recalculate-dbp-buffer-size.patch \
			file://0021-radeon-uvd-make-30M-as-minimum-for-MPEG4-dpb-buffer-.patch \
			file://0022-radeon-vce-implement-VCE-two-pipe-support.patch \
			file://0023-radeonsi-add-new-VI-PCI-IDs.patch \
			file://0024-gallium-util-get-h264-level-based-on-number-of-max-r.patch \
			file://0025-st-vdpau-add-h264-decoder-level-support.patch \
			file://0026-st-omx-dec-separate-create_video_codec-to-different-.patch \
			file://0027-vl-add-level-idc-in-sps.patch \
			file://0028-st-omx-dec-add-h264-decoder-level-support.patch \
			file://0029-st-va-add-h264-decoder-level-support.patch \
			file://0030-radeonsi-properly-set-the-raster_config-for-KV.patch \
			file://0031-radeonsi-properly-handler-raster_config-setup-on-CZ.patch \
"

# Install override from mesa.inc
do_install_append_amdfalconx86() {
	cp ${S}/include/EGL/eglplatform.h ${D}${includedir}/EGL/eglplatform.h
}

EXTRA_OECONF_append_amdfalconx86 = " \
		 --enable-r600-llvm-compiler \
		 --enable-llvm-shared-libs \
		"

