DESCRIPTION = "Linux Kernel v3.12"
SECTION = "kernel"
LICENSE = "GPLv2"

LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

inherit kernel cml1-config

SRC_URI = "http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto-dev/snapshot/linux-yocto-dev-${PV}.tar.bz2;name=kernel \
           file://defconfig \
           file://0000-yocto-amd-drm-radeon-backport-support-from-kernel-version-3.12.10.patch \
           file://0001-yocto-amd-drm-radeon-add-vm_set_page-tracepoint.patch \
           file://0002-yocto-amd-drm-radeon-cleanup-flushing-on-CIK-v3.patch \
           file://0003-yocto-amd-drm-radeon-cleanup-DMA-HDP-flush-on-CIK-v2.patch \
           file://0004-yocto-amd-drm-radeon-allow-semaphore-emission-to-fail.patch \
           file://0005-yocto-amd-drm-radeon-improve-ring-debugfs-a-bit.patch \
           file://0006-yocto-amd-drm-radeon-report-the-real-offset-in-radeon_sa_bo_du.patch \
           file://0007-yocto-amd-drm-radeon-update-fence-values-in-before-reporting-t.patch \
           file://0008-yocto-amd-drm-radeon-cleanup-radeon_ttm-debugfs-handling.patch \
           file://0009-yocto-amd-drm-radeon-add-VRAM-debugfs-access-v3.patch \
           file://0010-yocto-amd-drm-radeon-add-GART-debugfs-access-v3.patch \
           file://0011-yocto-amd-drm-radeon-fix-VMID-use-tracking.patch \
           file://0012-yocto-amd-drm-radeon-add-missing-trace-point.patch \
           file://0013-yocto-amd-drm-radeon-add-semaphore-trace-point.patch \
           file://0014-yocto-amd-drm-radeon-add-VMID-allocation-trace-point.patch \
           file://0015-yocto-amd-drm-radeon-add-uvd-debugfs-support.patch \
           file://0016-yocto-amd-drm-radeon-add-radeon_vm_bo_update-trace-point.patch \
           file://0017-yocto-amd-drm-radeon-drop-CP-page-table-updates-cleanup-v2.patch \
           file://0018-yocto-amd-drm-radeon-add-large-PTE-support-for-NI-SI-and-CIK-v.patch \
           file://0019-yocto-amd-drm-radeon-add-proper-support-for-RADEON_VM_BLOCK_SI.patch \
           file://0020-yocto-amd-drm-radeon-WIP-add-copy-trace-point.patch \
           file://0021-yocto-amd-drm-radeon-cik-Return-backend-map-information-to-use.patch \
           file://0022-yocto-amd-drm-radeon-cik-Add-macrotile-mode-array-query.patch \
           file://0023-yocto-amd-drm-radeon-set-correct-number-of-banks-for-CIK-chips.patch \
           file://0024-yocto-amd-drm-radeon-don-t-power-gate-paused-UVD-streams.patch \
           file://0025-yocto-amd-drm-radeon-dpm-retain-user-selected-performance-leve.patch \
           file://0026-yocto-amd-drm-radeon-remove-generic-rptr-wptr-functions-v2.patch \
           file://0027-yocto-amd-drm-radeon-initial-VCE-support-v4.patch \
           file://0028-yocto-amd-drm-radeon-add-VCE-ring-query.patch \
           file://0029-yocto-amd-drm-radeon-add-VCE-version-parsing-and-checking.patch \
           file://0030-yocto-amd-drm-radeon-add-callback-for-setting-vce-clocks.patch \
           file://0031-yocto-amd-drm-radeon-dpm-move-platform-caps-fetching-to-a-sepa.patch \
           file://0032-yocto-amd-drm-radeon-dpm-fill-in-some-initial-vce-infrastructu.patch \
           file://0033-yocto-amd-drm-radeon-dpm-fetch-vce-states-from-the-vbios.patch \
           file://0034-yocto-amd-drm-radeon-fill-in-set_vce_clocks-for-CIK-asics.patch \
           file://0035-yocto-amd-drm-radeon-add-vce-dpm-support-for-CI.patch \
           file://0036-yocto-amd-drm-radeon-enable-vce-dpm-on-CI.patch \
           file://0037-yocto-amd-drm-radeon-add-vce-dpm-support-for-KV-KB.patch \
           file://0038-yocto-amd-drm-radeon-dpm-enable-dynamic-vce-state-switching-v2.patch \
           file://0039-yocto-amd-drm-radeon-dpm-properly-enable-disable-vce-when-vce-.patch \
           file://0040-yocto-amd-drm-radeon-add-vce-debugfs-support.patch \
           file://0041-yocto-amd-drm-radeon-add-support-for-vce-2.0-clock-gating.patch \
           file://0042-yocto-amd-drm-radeon-cik-enable-disable-vce-cg-when-encoding.patch \
           file://0043-yocto-amd-drm-radeon-fix-CP-semaphores-on-CIK.patch \
           file://0044-yocto-amd-drm-radeon-disable-dynamic-powering-vce.patch \
	   file://0045-yocto-amd-drm-radeon-add-Mullins-chip-family.patch \
	   file://0046-yocto-amd-drm-radeon-update-cik-init-for-Mullins.patch \
	   file://0047-yocto-amd-drm-radeon-add-Mullins-UVD-support.patch \
	   file://0048-yocto-amd-drm-radeon-add-Mullins-dpm-support.patch \
	   file://0049-yocto-amd-drm-radeon-modesetting-updates-for-Mullins.patch \
	   file://0050-yocto-amd-drm-radeon-add-pci-ids-for-Mullins.patch \
	   file://0051-yocto-amd-drm-radeon-add-Mulins-VCE-support.patch \
	   file://0052-yocto-amd-clear-exceptions-in-AMD-FXSAVE-workaround.patch \
	   file://0053-yocto-amd-i2c-piix4-add-support-for-AMD-ML-and-CZ-SMBus-changes.patch \
	   file://0054-yocto-amd-i2c-piix4-use-different-message-for-AMD-auxiliary-SMBus-controller.patch \
	   file://0055-yocto-amd-change-acpi-enforce-resources-to-lax.patch"

S = "${WORKDIR}/linux-yocto-dev-${PV}"

SRC_URI[kernel.md5sum] = "a9564529d2d310c1d93e1c0c5adc0360"
SRC_URI[kernel.sha256sum] = "6e4c00016653ead0f57d7cd38364cf1194568301fbd37103b400a03145b369aa"
