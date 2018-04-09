FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " file://0001-amdgpu-Implement-SVM-v3.patch \
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
	       file://0029-amdgpu-support-16-ibs-per-submit-for-PAL-SRIOV.patch \
	       file://0030-amdgpu-hybrid-add-a-flag-of-memory-allcation-from-to.patch \
	       file://0031-amdgpu-unify-dk-drm-header-changes.patch \
	       file://0032-amdgpu-add-interface-for-reserve-unserve-vmid-v2.patch \
	       file://0033-amdgpu-HYBRID-add-AMDGPU_CAPABILITY_SSG_FLAG.patch \
	       file://0037-tests-amdgpu-HYBRID-add-SSG-unit-test.patch \
	       file://0044-amdgpu-HYBRID-change-to-use-amdgpu_bo_free.patch \
	       file://amdgpu.ids \
"

EXTRA_OECONF = "--disable-cairo-tests \
                 --enable-omap-experimental-api \
                 --enable-install-test-programs \
                 --disable-manpages \
                 --disable-valgrind \
                 --enable-amdgpu \
                 --enable-radeon \
                "

do_install_append() {
        cp ${S}/include/drm/amdgpu_drm.h ${D}/usr/include/libdrm
        install -vd  ${D}/usr/share/libdrm
        cp ${WORKDIR}/amdgpu.ids ${D}/usr/share/libdrm
}

