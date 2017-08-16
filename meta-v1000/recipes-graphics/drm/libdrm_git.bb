SUMMARY = "Userspace interface to the kernel DRM services"
DESCRIPTION = "The runtime library for accessing the kernel DRM services.  DRM \
stands for \"Direct Rendering Manager\", which is the kernel portion of the \
\"Direct Rendering Infrastructure\" (DRI).  DRI is required for many hardware \
accelerated OpenGL drivers."

HOMEPAGE = "http://dri.freedesktop.org"
SECTION = "x11/base"
LICENSE = "MIT"
LIC_FILES_CHKSUM_amd = "file://xf86drm.c;beginline=9;endline=32;md5=c8a3b961af7667c530816761e949dc71"
PROVIDES = "drm"
PV = "git"

inherit autotools pkgconfig

SRCREV = "23e234a3503f51b9d9c585123d33b936f522808d"
DEPENDS = "libpthread-stubs udev libpciaccess freetype libxext cairo fontconfig libxrender libpng pixman"

SRC_URI = "git://anongit.freedesktop.org/mesa/drm;branch=master \
	       file://0001-amdgpu-Implement-SVM-v3.patch \
	       file://0002-amdgpu-SVM-test-v3.patch \
	       file://0003-amdgpu-Implement-multiGPU-SVM-support-v3.patch \
	       file://0004-tests-amdgpu-Add-test-for-multi-GPUs-SVM-test-v4.patch \
	       file://0005-amdgpu-add-query-for-aperture-va-range.patch \
	       file://0006-amdgpu-expose-the-AMDGPU_GEM_CREATE_NO_EVICT-flag-v2.patch \
	       file://0007-amdgpu-add-sparse-flag-for-bo-creatation-v2.patch \
	       file://0008-amdgpu-add-amdgpu_query_capability-interface-v2.patch \
	       file://0009-amdgpu-add-amdgpu_find_bo_by_cpu_mapping-interface.patch \
	       file://0010-amdgpu-support-alloc-va-from-range-v2.patch \
	       file://0011-tests-amdgpu-add-alloc-va-from-range-test-v2.patch \
	       file://0012-amdgpu-change-max-allocation.patch \
	       file://0013-amdgpu-add-bo-handle-to-hash-table-when-cpu-mapping.patch \
	       file://0014-amdgpu-add-amdgpu_bo_inc_ref-function.patch \
	       file://0015-amdgpu-Make-amdgpu_get_auth-to-non-static.patch \
	       file://0016-amdgpu-Add-interface-amdgpu_get_fb_id-v2.patch \
	       file://0017-amdgpu-Add-interface-amdgpu_get_bo_from_fb_id-v2.patch \
	       file://0018-amdgpu-tests-Add-the-test-case-for-amdgpu_get_fb_id-.patch \
	       file://0019-drm-amdgpu-add-freesync-ioctl-defines.patch \
	       file://0020-amdgpu-implement-direct-gma.patch \
	       file://0021-tests-amdgpu-add-direct-gma-test.patch \
	       file://0022-amdgpu-add-new-semaphore-support-v2.patch \
	       file://0023-implement-import-export-sem.patch \
	       file://0024-test-case-for-export-import-sem.patch \
	       file://0025-amdgpu-Sparse-resource-support-for-Vulkan-v2.patch \
	       file://0026-tests-amdgpu-add-uvd-enc-unit-tests-v2.patch \
	       file://0027-tests-amdgpu-add-uve-ib-header.patch \
	       file://0028-tests-amdgpu-implement-hevc-encode-test-v2.patch \
	       file://0029-amdgpu-support-16-ibs-per-submit-for-PAL-SRIOV.patch \
	       file://0030-amdgpu-hybrid-add-a-flag-of-memory-allcation-from-to.patch \
	       file://0031-amdgpu-unify-dk-drm-header-changes.patch \
	       file://0032-amdgpu-add-interface-for-reserve-unserve-vmid-v2.patch \
	       file://0033-amdgpu-HYBRID-add-AMDGPU_CAPABILITY_SSG_FLAG.patch \
	       file://0034-tests-amdgpu-bypass-UVD-CS-tests-on-raven.patch \
	       file://0035-tests-amdgpu-bypass-UVD-ENC-tests-on-raven.patch \
	       file://0036-tests-amdgpu-bypass-VCE-tests-on-raven.patch \
	       file://0037-tests-amdgpu-HYBRID-add-SSG-unit-test.patch \
	       file://0038-amdgpu-Add-gpu-always-on-cu-bitmap.patch \
	       file://0039-test-amdgpu-fix-test-failure-for-SI.patch \
	       file://amdgpu.ids \
"

S = "${WORKDIR}/git"

EXTRA_OECONF = "--disable-cairo-tests \
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

do_install_append() {
	cp ${S}/include/drm/amdgpu_drm.h ${D}/usr/include/libdrm
	install -vd  ${D}/usr/share/libdrm
	cp ${WORKDIR}/amdgpu.ids ${D}/usr/share/libdrm
}
