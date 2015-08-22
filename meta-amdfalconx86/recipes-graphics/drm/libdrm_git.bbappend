FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_amdfalconx86 = "\
			git://anongit.freedesktop.org/git/mesa/drm;branch=amdgpu \
			file://0001-amdgpu-validate-the-upper-limit-of-virtual-address-v.patch \
			file://0002-fix-code-alignment-first.patch \
			file://0003-amdgpu-fix-vamgr_free_va-logic.patch \
			file://0004-amdgpu-implement-amdgpu_cs_query_reset_state.patch \
			file://0005-amdgpu-fix-a-valgrind-warning.patch \
			file://0006-amdgpu-fix-the-number-of-IB-size-enums.patch \
			file://0007-amdgpu-remove-unused-AMDGPU_IB_RESOURCE_PRIORITY.patch \
			file://0008-amdgpu-replace-alloca-with-calloc-v2.patch \
			file://0009-amdgpu-add-amdgpu_bo_list_update-interface-v2.patch \
			file://0010-amdgpu-remove-bo_vas-hash-table-v2.patch \
			file://0011-amdgpu-add-helper-for-VM-mapping-v2.patch \
			file://0012-amdgpu-add-new-AMDGPU_TILING-flags.patch \
			file://0013-amdgpu-add-IB-sharing-support-v2.patch \
			file://0014-tests-amdgpu-add-shared-IB-submission-test-v2.patch \
			file://0015-amdgpu-make-vamgr-global.patch \
			file://0016-tests-amdgpu-implement-VCE-unit-tests.patch \
			file://0017-amdgpu-stop-checking-flag-masks.patch \
			file://0018-amdgpu-rename-GEM_OP_SET_INITIAL_DOMAIN-GEM_OP_SET_P.patch \
			file://0019-amdgpu-add-max_memory_clock-for-interface-query.patch \
			file://0020-amdgpu-add-vram_type-and-vram_bit_width-for-interfac.patch \
			file://0021-amdgpu-add-ce_ram_size-for-interface-query.patch \
			file://0022-amdgpu-add-ib_start_alignment-and-ib_size_alignment-.patch \
			file://0023-amdgpu-get-rid-of-IB-pool-management-v3.patch \
			file://0024-tests-amdgpu-manage-IB-in-client-side.patch \
			file://0025-amdgpu-don-t-use-amdgpu_cs_create_ib-for-allocation-.patch \
			file://0026-amdgpu-remove-amdgpu_ib.patch \
			file://0027-amdgpu-remove-amdgpu_ib-helpers.patch \
			file://0028-amdgpu-remove-bo_handle-from-amdgpu_cs_ib_info-IBs-s.patch \
			file://0029-amdgpu-add-zero-timeout-check-in-amdgpu_cs_query_fen.patch \
			file://0030-amdgpu-allow-exporting-KMS-handles-with-render-nodes.patch \
			file://0031-amdgpu-use-alloca-and-malloc-in-critical-codepaths-v.patch \
			file://0032-amdgpu-fix-valgrind-warnings.patch \
			file://0033-amdgpu-fix-double-mutex_unlock-in-amdgpu_bo_import.patch \
			file://0034-amdgpu-add-amdgpu_query_gds_info.patch \
			file://0035-amdgpu-cleanup-gds-specific-alloc-free-functions.patch \
			file://0036-amdgpu-merge-amdgpu_drm.h-from-kernel.patch \
			file://0037-amdgpu-explicitly-unmap-GPU-mapping-on-BO-destructio.patch \
			file://0038-amdgpu-remove-flink-export-workaround-v2.patch \
			file://0039-amdgpu-cleanup-VA-IOCTL-handling.patch \
			file://0040-amdgpu-do-NULL-check-for-bo-handle-in-amdgpu_bo_quer.patch \
			file://0041-amdgpu-update-to-latest-kernel-header.patch \
			file://0042-amdgpu-remove-pointer-arithmetic-from-command-submis.patch \
			file://0043-amdgpu-add-CS-dependencies-v2.patch \
			file://0044-gitignore-add-some-generated-amdgpu-files.patch \
			file://0045-amdgpu-cleanup-public-interface-style.patch \
			file://0046-amdgpu-remove-reference-to-AMD-specific-error-codes.patch \
			file://0047-drm-amdgpu-allow-passing-absolute-timeouts-to-amdgpu.patch \
			file://0048-amdgpu-check-the-user-fence-only-if-the-IP-supports-.patch \
			file://0049-amdgpu-add-base_preferred-parameter-to-amdgpu_vamgr_.patch \
			file://0050-amdgpu-add-va-allocation-intefaces.patch \
			file://0051-amdgpu-add-va-range-query-interface.patch \
			file://0052-amdgpu-improve-the-amdgpu_cs_query_fence_status-inte.patch \
			file://0053-amdgpu-use-common-fence-structure-for-dependencies-a.patch \
			file://0054-amdgpu-Use-drmIoctl-in-amdgpu_ioctl_wait_cs.patch \
			file://0055-tests-also-install-tests-app.patch \
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
