FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_amdfalconx86 = "\
			git://anongit.freedesktop.org/git/mesa/drm;branch=amdgpu \
			file://0001-amdgpu-validate-the-upper-limit-of-virtual-address-v.patch \
			file://0002-fix-code-alignment-first.patch \
			file://0003-amdgpu-fix-vamgr_free_va-logic.patch \
			file://0004-amdgpu-implement-amdgpu_cs_query_reset_state.patch \
			file://0005-amdgpu-fix-a-valgrind-warning.patch \
			file://0006-amdgpu-fix-segfault-when-resources-are-NULL.patch \
			file://0007-amdgpu-fix-the-number-of-IB-size-enums.patch \
			file://0008-amdgpu-remove-unused-AMDGPU_IB_RESOURCE_PRIORITY.patch \
			file://0009-amdgpu-replace-alloca-with-calloc-v2.patch \
			file://0010-amdgpu-add-amdgpu_bo_list_update-interface-v2.patch \
			file://0011-amdgpu-remove-bo_vas-hash-table-v2.patch \
			file://0012-amdgpu-add-helper-for-VM-mapping-v2.patch \
			file://0013-amdgpu-add-new-AMDGPU_TILING-flags.patch \
			file://0014-amdgpu-add-new-AMDGPU_TILING-flags.patch \
			file://0015-amdgpu-add-IB-sharing-support-v2.patch \
			file://0016-tests-amdgpu-add-shared-IB-submission-test-v2.patch \
			file://0017-amdgpu-make-vamgr-global.patch \
			file://0018-tests-amdgpu-implement-VCE-unit-tests.patch \
			file://0019-amdgpu-stop-checking-flag-masks.patch \
			file://0020-amdgpu-rename-GEM_OP_SET_INITIAL_DOMAIN-GEM_OP_SET_P.patch \
			file://0021-amdgpu-add-max_memory_clock-for-interface-query.patch \
			file://0022-amdgpu-add-vram_type-and-vram_bit_width-for-interfac.patch \
			file://0023-amdgpu-add-ce_ram_size-for-interface-query.patch \
			file://0024-amdgpu-add-ib_start_alignment-and-ib_size_alignment-.patch \
			file://0025-amdgpu-get-rid-of-IB-pool-management-v3.patch \
			file://0026-tests-amdgpu-manage-IB-in-client-side.patch \
			file://0027-amdgpu-don-t-use-amdgpu_cs_create_ib-for-allocation-.patch \
			file://0028-amdgpu-remove-amdgpu_ib.patch \
			file://0029-amdgpu-remove-amdgpu_ib-helpers.patch \
			file://0030-amdgpu-remove-bo_handle-from-amdgpu_cs_ib_info-IBs-s.patch \
			file://0031-amdgpu-add-zero-timeout-check-in-amdgpu_cs_query_fen.patch \
			file://0032-amdgpu-allow-exporting-KMS-handles-with-render-nodes.patch \
			file://0033-amdgpu-use-alloca-and-malloc-in-critical-codepaths-v.patch \
			file://0034-amdgpu-fix-valgrind-warnings.patch \
			file://0035-amdgpu-fix-double-mutex_unlock-in-amdgpu_bo_import.patch \
			file://0036-amdgpu-add-zero-timeout-check-in-amdgpu_cs_query_fen.patch \
			file://0037-amdgpu-add-amdgpu_query_gds_info.patch \
			file://0038-amdgpu-cleanup-gds-specific-alloc-free-functions.patch \
			file://0039-amdgpu-merge-amdgpu_drm.h-from-kernel.patch \
			file://0040-amdgpu-explicitly-unmap-GPU-mapping-on-BO-destructio.patch \
			file://0041-amdgpu-remove-flink-export-workaround-v2.patch \
			file://0042-amdgpu-cleanup-VA-IOCTL-handling.patch \
			file://0043-amdgpu-do-NULL-check-for-bo-handle-in-amdgpu_bo_quer.patch \
			file://0044-amdgpu-update-to-latest-kernel-header.patch \
			file://0045-amdgpu-remove-pointer-arithmetic-from-command-submis.patch \
			file://0046-amdgpu-add-CS-dependencies-v2.patch \
			file://0047-gitignore-add-some-generated-amdgpu-files.patch \
			file://0048-amdgpu-cleanup-public-interface-style.patch \
			file://0049-amdgpu-remove-reference-to-AMD-specific-error-codes.patch \
			file://0050-drm-amdgpu-allow-passing-absolute-timeouts-to-amdgpu.patch \
			file://0051-amdgpu-check-the-user-fence-only-if-the-IP-supports-.patch \
			file://0052-amdgpu-Use-drmIoctl-in-amdgpu_ioctl_wait_cs.patch \
			file://0053-amdgpu-add-base_preferred-parameter-to-amdgpu_vamgr_.patch \
			file://0054-amdgpu-add-va-allocation-intefaces.patch \
			file://0055-amdgpu-add-va-range-query-interface.patch \
			file://0056-amdgpu-improve-the-amdgpu_cs_query_fence_status-inte.patch \
			file://0057-amdgpu-use-common-fence-structure-for-dependencies-a.patch \
			file://0058-drm-fix-the-ALIGN-macro-to-avoid-value-clamp.patch \
			file://0059-tests-amdgpu-remove-the-duplicate-IB-allocation-for-.patch \
			file://0060-amdgpu-fix-bs-buffer-size-for-vce-test.patch \
			file://0061-amdgpu-move-management-of-user-fence-from-libdrm-to-.patch \
			file://0062-amdgpu-add-flags-parameter-for-amdgpu_va_range_alloc.patch \
			file://0063-amdgpu-add-amdgpu_bo_va_op-for-va-map-unmap-support-.patch \
			file://0064-test-amdgpu-fix-a-bug-in-VCE-UVD-test-introduced-by-.patch \
			file://0065-amdgpu-add-VCE-harvesting-instance-query.patch \
			file://0066-amdgpu-tests-Use-buf_handle-in-amdgpu_bo_alloc_and_m.patch \
			file://0067-amdgpu-tests-Cast-CPU-map-argument-of-amdgpu_bo_allo.patch \
			file://0068-tests-also-install-tests-app.patch \
"

SRCREV_amdfalconx86 = "f7c157caada4cf12bb884412e60ef013f690eb3e"
PV_amdfalconx86 = "2.4.61+git${SRCPV}"

EXTRA_OECONF_append_amdfalconx86 = " --enable-amdgpu \
				     --enable-radeon \
"

FILES_${PN}-amdgpu = "${libdir}/libdrm_amdgpu.so.*"

do_install_append_amdfalconx86() {
	cp ${S}/include/drm/amdgpu_drm.h ${D}/usr/include/libdrm
}
