FILESEXTRAPATHS_prepend_amdfalconx86 := "${THISDIR}/${PN}:"

SRCREV_amdfalconx86 = "2a9ab75914500b4d06b5133932521ce5edbf415c"
LIC_FILES_CHKSUM_amdfalconx86 = "file://docs/license.html;md5=6a23445982a7a972ac198e93cc1cb3de"
PV_amdfalconx86 = "10.7.0+git${SRCPV}"
DEPENDS_append_amdfalconx86 = " python-mako-native libdrm nettle"
GALLIUMDRIVERS_append_amdfalconx86 = ",r300,r600,radeonsi"
GALLIUMDRIVERS_LLVM_amdfalconx86 = "r300,svga${@',${GALLIUMDRIVERS_LLVM33}' if ${GALLIUMDRIVERS_LLVM33_ENABLED} else ',nouveau'}"
MESA_LLVM_RELEASE_amdfalconx86 = "3.7.0"

SRC_URI_amdfalconx86 = "\
			git://anongit.freedesktop.org/git/mesa/mesa;branch=amdgpu \
			file://0001-winsys-amdgpu-follow-libdrm-change-to-move-user-fenc.patch \
			file://0002-winsys-amdgpu-use-amdgpu_bo_va_op-for-va-map-unmap-v.patch \
			file://0003-winsys-amdgpu-correctly-wait-for-shared-buffers-to-b.patch \
			file://0004-winsys-amdgpu-add-a-specific-error-message-for-cs_su.patch \
			file://0005-winsys-radeon-add-a-specific-error-message-for-cs_su.patch \
			file://0006-radeonsi-always-flush-framebuffer-caches-at-the-begi.patch \
			file://0007-radeonsi-flush-if-the-memory-usage-for-an-IB-is-too-.patch \
			file://0008-winsys-amdgpu-check-num_active_ioctls-before-calling.patch \
			file://0009-winsys-amdgpu-clear-user-fence-BO-after-allocating-i.patch \
			file://0010-radeon-vce-disable-VCE-dual-instance-for-harvest-par.patch \
			file://0011-winsys-amdgpu-fix-user-fences.patch \
			file://0012-winsys-amdgpu-partial-revert-fix-user-fences.patch \
			file://0013-winsys-amdgpu-make-amdgpu_winsys_create-public.patch \
			file://0014-radeonsi-rework-how-shader-pointers-to-descriptors-a.patch \
			file://0015-radeonsi-completely-rework-updating-descriptors-with.patch \
			file://0016-winsys-amdgpu-fix-the-type-of-memory-usage-counters.patch \
			file://0017-radeonsi-add-harvest-support-for-CI-VI-parts-v3.patch \
			file://0018-st-omx-dec-h264-fix-field-picture-type-0-poc-disorde.patch \
			file://0019-winsys-amdgpu-calculate-the-maximum-number-of-comput.patch \
			file://0020-radeonsi-enable-VGPR-spilling-on-VI.patch \
			file://0021-radeonsi-fix-a-Unigine-Heaven-hang-when-drirc-is-mis.patch \
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

